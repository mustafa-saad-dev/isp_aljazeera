import 'package:equatable/equatable.dart';

import '../../core/status/request_status.dart';
import '../../models/auth/company/company.dart';

class AuthState extends Equatable {
  final RequestStatus status;
  final String? message;
  final bool registered;
  final List<Company> companies;

  const AuthState({
    this.status = RequestStatus.initial,
    this.message,
    this.registered = false,
    this.companies = const [],
  });

  AuthState copyWith({
    RequestStatus? status,
    String? message,
    bool? registered,
    List<Company>? companies,
    bool clearUser = false,
    bool clearMessage = false,
    bool clearRegistered = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
      registered: clearRegistered ? false : (registered ?? this.registered),
      companies: companies ?? this.companies,
    );
  }

  bool get isLoading => status == RequestStatus.loading;
  bool get isLoggedIn => status == RequestStatus.success;
  bool get isError => status == RequestStatus.error;
  bool get isOffline => status == RequestStatus.offline;

  @override
  List<Object?> get props => [status, message, registered, companies];
}
