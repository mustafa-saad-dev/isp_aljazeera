import 'package:equatable/equatable.dart';
import '../../core/status/request_status.dart';

class ForgotPasswordState extends Equatable {
  final RequestStatus status;
  final String? message;
  final String identifier;
  final String otp;
  final int step;

  const ForgotPasswordState({
    this.status = RequestStatus.initial,
    this.message,
    this.identifier = '',
    this.otp = '',
    this.step = 1,
  });

  ForgotPasswordState copyWith({
    RequestStatus? status,
    String? message,
    String? identifier,
    String? otp,
    int? step,
    bool clearMessage = false,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
      identifier: identifier ?? this.identifier,
      otp: otp ?? this.otp,
      step: step ?? this.step,
    );
  }

  bool get isLoading => status == RequestStatus.loading;
  bool get isError => status == RequestStatus.error;
  bool get isOffline => status == RequestStatus.offline;

  @override
  List<Object?> get props => [status, message, identifier, otp, step];
}
