import 'package:dio/dio.dart';

import '../../core/localization/app_translations.dart';
import '../status/request_status.dart';

class Failure {
  const Failure(this.status, this.message);

  final RequestStatus status;
  final String message;
}

class DioErrorHandler {
  DioErrorHandler._();

  static Failure resolve(DioException e) {
    final tr = AppTranslations.tr;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return Failure(RequestStatus.offline, tr('noInternet'));
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 404) {
          return Failure(RequestStatus.empty, tr('emptyData'));
        }
        return Failure(
          RequestStatus.error,
          _responseMessage(e) ?? tr('serverError'),
        );
      case DioExceptionType.cancel:
        return Failure(RequestStatus.empty, tr('requestCancelled'));
      case DioExceptionType.transformTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return Failure(RequestStatus.error, tr('serverError'));
    }
  }

  static String? _responseMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic> && data['message'] is String) {
      return data['message'];
    }
    return null;
  }
}
