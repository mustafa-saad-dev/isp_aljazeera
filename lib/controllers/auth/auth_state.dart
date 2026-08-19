import 'package:equatable/equatable.dart';

import '../../core/status/request_status.dart';
import '../../models/auth/user_model/user_model.dart';

class AuthState extends Equatable {
  final RequestStatus status;
  final UserModel? user;
  final String? message;
  final bool registered;

  const AuthState({
    this.status = RequestStatus.initial,
    this.user,
    this.message,
    this.registered = false,
  });

  AuthState copyWith({
    RequestStatus? status,
    UserModel? user,
    String? message,
    bool? registered,
    bool clearUser = false,
    bool clearMessage = false,
    bool clearRegistered = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      message: clearMessage ? null : (message ?? this.message),
      registered: clearRegistered ? false : (registered ?? this.registered),
    );
  }

  bool get isLoading => status == RequestStatus.loading;
  bool get isLoggedIn => user != null;
  bool get isError => status == RequestStatus.error;
  bool get isOffline => status == RequestStatus.offline;

  @override
  List<Object?> get props => [status, user, message, registered];
}
