import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt_lib;

class AesEncryptionService {
  AesEncryptionService._();

  static final _key = encrypt_lib.Key.fromUtf8(
    'abcdefghijuklmno0123456789012345',
  );

  static String encryptPayload(String plainText) {
    final iv = encrypt_lib.IV.fromSecureRandom(16);
    final encrypter = encrypt_lib.Encrypter(
      encrypt_lib.AES(_key, mode: encrypt_lib.AESMode.cbc),
    );
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return base64Encode(iv.bytes + encrypted.bytes);
  }

  static String decryptPayload(String cipherBase64) {
    final fullBytes = base64Decode(cipherBase64);
    final iv = encrypt_lib.IV(Uint8List.sublistView(fullBytes, 0, 16));
    final cipherBytes = Uint8List.sublistView(fullBytes, 16);
    final encrypter = encrypt_lib.Encrypter(
      encrypt_lib.AES(_key, mode: encrypt_lib.AESMode.cbc),
    );
    final encrypted = encrypt_lib.Encrypted(cipherBytes);
    return encrypter.decrypt(encrypted, iv: iv);
  }

  static Map<String, dynamic> encryptBody(Map<String, dynamic> body) {
    final jsonStr = jsonEncode(body);
    final encrypted = encryptPayload(jsonStr);
    return {'payload': encrypted};
  }

  static Map<String, dynamic> decryptResponse(dynamic data) {
    if (data is Map<String, dynamic>) {
      final payload = data['payload'];
      if (payload is String && payload.isNotEmpty) {
        final decrypted = decryptPayload(payload);
        final decoded = jsonDecode(decrypted);
        if (decoded is Map<String, dynamic>) return decoded;
        return {'data': decoded};
      }
      return data;
    }
    if (data is String) {
      try {
        final decrypted = decryptPayload(data);
        final decoded = jsonDecode(decrypted);
        if (decoded is Map<String, dynamic>) return decoded;
        return {'data': decoded};
      } catch (_) {
        return {'data': data};
      }
    }
    return {'data': data};
  }

  static String decryptToken(String encryptedToken) {
    try {
      return decryptPayload(encryptedToken);
    } catch (_) {
      return encryptedToken;
    }
  }
}
