class Api2Endpoints {
  Api2Endpoints._();

  // ── Base ──
  static String baseUrl = '';

  // ── Dashboard ──
  static const String dashboard = '/dashboard';
  static String widgetData(String source) => '/widgetData/internal/$source';

  // ── Auth ──
  static const String login = '/login';
  static const String logout = '/logout';
  static const String me = '/auth';

  // ── Users ──
  static const String userList = '/index/user';
  static const String userOnline = '/index/online';
  static const String userCreate = '/user';
  static const String userOverview = '/user/overview';
  static const String userActivationData = '/user/activationData';
  static const String userActivate = '/user/activate';
  static const String userEnable = '/user/enable';
  static const String userDisable = '/user/disable';
  static const String userProfile = '/user/changeProfile';
  static const String userDisconnect = '/user/disconnect/userid';
  static const String userRename = '/user/rename';
  static const String userLocation = '/user/location';
  static const String userSessions = '/index/UserSessions';
  static const String userReceipts = '/index/UserReceipts';
  static const String userHistory = '/index/UserHistory';
  static const String userQuota = '/index/Quota';
  static const String userDocuments = '/index/UserDocuments';
  static const String userJournal = '/index/UserJournal';
  static const String userMac = '/mac';
  static const String userAddTraffic = '/user/addTraffic';
  static const String userTraffic = '/user/traffic';
  static const String userNetworksTraffic = '/userNetworksTraffic';
  static const String userFreezone = '/freezone';
  static const String userAllowedExtensions = '/allowedExtensions';
  static const String userExtensionData = '/user/extensionData';

  // ── Profiles ──
  static String profileList(int type) => '/list/profile/$type';

  // ── Invoices ──
  static const String invoiceDownload = '/userInvoice/download';
  static const String invoiceIndex = '/index/UserInvoices';
  static String invoiceInfo(int id) => '/userInvoice/$id';
  static const String invoicePay = '/user/invoice/pay';
  static const String invoiceUnpay = '/user/invoice/unpay';

  // ── Tickets ──
  static const String ticketCreate = '/ticket/create';
  static const String ticketClose = '/ticket/close';
  static const String ticketChat = '/ticket';
  static const String ticketIndex = '/index/tickets';
  static String ticketInfo(int id) => '/ticket/$id';

  // ── Managers ──
  static const String managerTree = '/manager/tree';
  static const String managerIndex = '/index/manager';
  static const String managerCreate = '/manager';
  static String managerUpdate(int id) => '/manager/$id';
  static String managerOverview(int id) => '/manager/overview/$id';
  static String managerJournal(int id) => '/index/ManagerJournal/$id';
  static String managerReceipts(int id) => '/index/ManagerReceipts/$id';
  static String managerInvoices(int id) => '/index/ManagerInvoices/$id';
  static const String managerDeposit = '/manager/deposit';
  static const String managerWithdraw = '/manager/withdraw';
  static const String managerDebtsJournal = '/index/ManagerDebtsJournal';

  // ── Logs ──
  static const String syslogEvents = '/syslog/events';
  static const String syslogIndex = '/index/syslog';
  static const String userAuthLog = '/index/userauthlog';

  // ── Reports ──
  static const String reportActivations = '/report/activations';
  static const String reportProfits = '/report/profits';
  static const String usersReportRegistration = '/usersReport/registration';
  static const String usersReportPerProfile = '/usersReport/perProfile';
}
