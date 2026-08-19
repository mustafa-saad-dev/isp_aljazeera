# SAS4 Radius Integration Plan

## Overview
Integrate SAS4 (sasradius.com) admin API into the ISP management app. The flow:
1. **API1 login** (plain) → server returns list of companies
2. **Company selection** → user picks a company (URL + credentials provided by API1)
3. **API2 login** (AES encrypted) → login to the company's SAS4 instance
4. **Dashboard** → display real data from SAS4 (users, online users, etc.)

---

## Phase 1: Fix AES Encryption (CryptoJS OpenSSL Compatibility)

**Problem**: Our current `AesEncryptionService` uses `Key.fromUtf8()` (raw UTF-8 bytes as key). The Postman/SAS4 frontend uses `CryptoJS.AES.encrypt(data, passphrase)` which uses OpenSSL "Salted__" format with EVP_BytesToKey (MD5) key derivation. These are **incompatible**.

**CryptoJS OpenSSL format**:
- Encrypt: random 8-byte salt → EVP_BytesToKey(passphrase, salt, MD5) → AES-CBC(plaintext, key, iv) → `base64("Salted__" + salt + ciphertext)`
- Decrypt: parse `base64 → "Salted__" + 8-byte salt + ciphertext` → EVP_BytesToKey → decrypt

**Changes**:
- `lib/core/encryption/aes_encryption_service.dart` → rewrite to match OpenSSL format
- No external packages needed — implement EVP_BytesToKey + MD5 manually using `dart:crypto` and `dart:typed_data`

**File**: `lib/core/encryption/aes_encryption_service.dart`

---

## Phase 2: Update API2 Endpoints (SAS4 Routes)

**File**: `lib/core/api/api2/api2_endpoint.dart`

Replace placeholder endpoints with all SAS4 endpoints from the Postman collection:

```
Auth:
  login          → POST /login
  logout         → GET  /logout (need to verify)

Users:
  userList       → POST /index/user
  userOnline     → POST /index/online
  userCreate     → POST /user
  userUpdate     → PUT  /user/{id}
  userDelete     → DELETE /user/{id}
  userRename     → PUT  /user/rename/{id}
  userLocation   → POST /user/location/{id}
  userProfile    → POST /user/changeProfile
  userDisconnect → GET  /user/disconnect/userid/{id}
  userOverview   → GET  /user/overview/{id}
  userActivationData → GET /user/activationData/{id}
  userActivate   → POST /user/activate
  userEnable     → POST /user/enable
  userDisable    → POST /user/disable
  userSessions   → POST /index/UserSessions/{id}
  userReceipts   → POST /index/UserReceipts/{id}
  userHistory    → POST /index/UserHistory/{id}
  userQuota      → POST /index/Quota/{id}
  userMac        → GET  /mac/{id}
  userDocuments  → POST /index/UserDocuments/{id}
  userJournal    → POST /index/UserJournal/{id}
  userAddTraffic → POST /user/addTraffic
  userTraffic    → POST /user/traffic
  userNetworksTraffic → POST /userNetworksTraffic
  userFreezone   → GET  /freezone

Profiles:
  profileList    → GET  /list/profile/{type}

Invoices:
  invoiceFile    → GET  /userInvoice/download/{id}
  invoiceList    → POST /index/UserInvoices/{id}
  invoiceInfo    → GET  /userInvoice/{id}
  invoiceCreate  → POST /index/UserInvoices
  invoiceUpdate  → PUT  /userInvoice/{id}
  invoicePay     → GET  /user/invoice/pay/{id}
  invoiceUnpay   → GET  /user/invoice/unpay/{id}
  invoicesAll    → POST /index/UserInvoices

Tickets:
  ticketCreate   → POST /ticket/create
  ticketClose    → POST /ticket/close
  ticketChat     → POST /ticket
  ticketList     → POST /index/tickets
  ticketInfo     → GET  /ticket/{id}

Managers:
  managerTreeAll → GET  /manager/tree
  managerTree    → POST /index/manager
  managerCreate  → POST /manager
  managerUpdate  → PUT  /manager/{id}
  managerInfo    → GET  /manager/overview/{id}
  managerJournal → POST /index/ManagerJournal/{id}
  managerReceipts → POST /index/ManagerReceipts/{id}
  managerInvoices → POST /index/ManagerInvoices/{id}
  managerDeposit → POST /manager/deposit
  managerWithdraw → POST /manager/withdraw

Logs:
  syslogEvents   → GET  /syslog/events
  syslogList     → POST /index/syslog
  userAuthLog    → POST /index/userauthlog

Reports:
  activationReport → POST /report/activations
  usersReport    → POST /usersReport/registration
  profitsReport  → POST /report/profits
  managerDebtsJournal → POST /index/ManagerDebtsJournal

Other:
  languages      → GET  /resources/languages
  allowedExtensions → GET  /allowedExtensions/{id}
  extensionData  → GET  /user/extensionData/{id}
```

---

## Phase 3: Update API2 Dio Client

**File**: `lib/core/api/api2/api2.dart`

The API2 Dio client needs adjustments:
1. **Login endpoint should NOT encrypt the request body** — it needs to send `{username, password}` directly, and the response returns `{token: "..."}` as plain JSON (NOT encrypted)
2. After login, the token is stored in memory via `TokenService.setApi2()`
3. All subsequent POST requests are encrypted
4. GET requests have no body (no encryption needed)
5. **Interceptor logic**: Skip encryption for login endpoint, skip decryption for login response

**Changes to interceptor**:
- `onRequest`: Check if path is `/login` → skip `encryptBody()` and skip adding Bearer header
- `onResponse`: Check if path is `/login` → skip `decryptResponse()`, extract token directly

---

## Phase 4: Company Model

**New files**:
- `lib/models/auth/company/company.dart` → `Company` model

```dart
class Company {
  final int id;
  final String name;
  final String url;      // SAS4 base URL (e.g., "http://demo4.sasradius.com/index.php/api/")
  final String username; // admin username for SAS4
  final String password; // admin password for SAS4
  
  // Constructor, copyWith, fromJson, etc.
}
```

---

## Phase 5: API1 Response Update — Companies

**File**: `lib/models/auth/login_result/login_result.dart`

Update `LoginResult` to include a list of companies from the API1 response:
```dart
class LoginResult {
  final String accessToken;
  final UserModel user;
  final List<Company> companies;  // ← NEW
}
```

**File**: `lib/services/auth/auth_service.dart` → parse companies from API1 response

---

## Phase 6: Company Selection View

**New files**:
- `lib/views/company/company_selection_view.dart` → company list + selection
- `lib/controllers/company/company_controller.dart` → cubit for company state
- `lib/controllers/company/company_state.dart` → state

**Flow**:
1. After API1 login → navigate to company selection (if companies.length > 1)
2. If only 1 company → auto-select and proceed to SAS4 login
3. Company selection view shows list of companies from API1
4. User taps a company → triggers SAS4 login via API2
5. On success → navigate to home

**Route**: Add `/companies` route

---

## Phase 7: SAS4 Service Layer

**New file**: `lib/services/sas4/sas4_service.dart`

Service that wraps API2 calls:
```dart
class Sas4Service {
  // Users
  Future<Sas4PaginatedResult<Sas4User>> listUsers({...});
  Future<List<Sas4User>> listOnlineUsers({...});
  // Profiles
  Future<List<Sas4Profile>> listProfiles(int type);
  // Tickets
  // Reports
  // etc.
}
```

---

## Phase 8: SAS4 Models (per-model folder)

**New files** under `lib/models/sas4/`:
- `sas4_user/sas4_user.dart`
- `sas4_online_user/sas4_online_user.dart`
- `sas4_profile/sas4_profile.dart`
- `sas4_paginated_result/sas4_paginated_result.dart`
- `sas4_ticket/sas4_ticket.dart`
- (more as needed)

Each with `fromJson` parsing.

---

## Phase 9: Dashboard View Update

**File**: `lib/views/home/home_view.dart`

Replace hardcoded data with real SAS4 data:
- **Users count** → from `listUsers` API
- **Online users count** → from `listOnlineUsers` API
- **Profile list** → from `listProfiles` API
- Keep existing layout structure, populate with real data

**New controller**: `lib/controllers/home/home_controller.dart` → cubit that fetches dashboard data

---

## Phase 10: Token Management for API2

**File**: `lib/core/storage/token_service.dart`

- `setApi2(String token)` — store in memory (already exists)
- `saveApi2Persistent(String token)` — store in secure storage (for "remember me")
- `loadApi2FromStorage()` — load from storage on app init
- `clearApi2()` — clear both memory and storage

Also update `init()` to load API2 token from storage if persisted.

---

## Phase 11: Routes & Navigation

**File**: `lib/core/routes/app_routes.dart` — add `companies` route
**File**: `lib/core/routes/app_router.dart` — add company selection route, update redirect logic

**Redirect flow**:
- Not logged in → `/login`
- Logged in, no SAS4 token → `/companies` (select company)
- Logged in, has SAS4 token → `/` (home)

---

## Phase 12: Translations

**Files**: `assets/lang/ar.json`, `assets/lang/en.json`, `assets/lang/ku.json`

Add keys for:
- Company selection screen
- Online users
- SAS4-related UI text
- Dashboard stats

---

## Execution Order

1. **Phase 1** — Fix AES encryption (critical, blocks everything)
2. **Phase 2** — Update API2 endpoints
3. **Phase 3** — Update API2 Dio client (login skip logic)
4. **Phase 4** — Company model
5. **Phase 5** — Update LoginResult with companies
6. **Phase 10** — Token management for API2
7. **Phase 6** — Company selection view + controller
8. **Phase 7** — SAS4 service layer
9. **Phase 8** — SAS4 models
10. **Phase 9** — Dashboard update
11. **Phase 11** — Routes & navigation
12. **Phase 12** — Translations

---

## Key Technical Notes

### AES OpenSSL Format (CryptoJS compatible)
```
Encrypt flow:
1. Generate random 8-byte salt
2. EVP_BytesToKey(passphrase, salt, keyLen=32, ivLen=16) using MD5
3. AES-CBC encrypt(plaintext, derived_key, derived_iv)
4. Output: base64("Salted__" + salt + ciphertext)

Decrypt flow:
1. base64 decode → raw bytes
2. Check first 8 bytes == "Salted__"
3. Extract 8-byte salt (bytes 8-16)
4. EVP_BytesToKey(passphrase, salt) → derive key + iv
5. AES-CBC decrypt(ciphertext, key, iv)
```

### SAS4 Login Response
From Postman: `{token: "..."}` — plain JSON, NOT encrypted.

### SAS4 POST Body Format
All POSTs: `{"payload": "<base64-encrypted>"}` — encrypted via OpenSSL format.

### GET Requests
No body, no encryption. Only `Authorization: Bearer <token>` header.

### SAS4 List/Index Requests
POST with encrypted body: `{page, count, sortBy, direction, search, columns}`
Response: `{status, data: [...], total: N}`
