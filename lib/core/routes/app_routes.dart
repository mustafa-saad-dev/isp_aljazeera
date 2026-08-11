class AppRoutes {
  AppRoutes._();

  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const pendingApproval = '/pending-approval';

  static const home = '/home';

  static const accounts = '/accounts';
  static const addEditAccount = '/accounts/add';

  static const subscribers = '/subscribers';
  static String subscriberDetails(dynamic id) => '/subscribers/$id';
  static String editSubscriber(dynamic id) => '/subscribers/$id/edit';
  static String activation(dynamic id) => '/subscribers/$id/activate';

  static const managers = '/managers';
  static String managerDetails(dynamic id) => '/managers/$id';
  static const settlement = '/managers/settlement';

  static const debts = '/debts';
  static const reports = '/reports';

  static const campaigns = '/campaigns';
  static String campaignDetails(dynamic id) => '/campaigns/$id';

  static const settings = '/settings';
}
