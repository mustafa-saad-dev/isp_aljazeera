import 'dart:async';
import 'package:dio/dio.dart';

import '../../core/config/app_config.dart';
import '../../core/storage/token_service.dart';

class ApiClient {
  ApiClient._();

  static final StreamController<void> _unauthorizedController =
      StreamController<void>.broadcast();
  static Stream<void> get onUnauthorized => _unauthorizedController.stream;

  static final StreamController<void> _enrollmentRequiredController =
      StreamController<void>.broadcast();
  static Stream<void> get onEnrollmentRequired =>
      _enrollmentRequiredController.stream;

  static final Dio dio = _create(AppConfig.mineBaseUrl);

  static final Dio sasradius = _create(AppConfig.sasradiusBaseUrl);

  static Dio _create(String baseUrl) {
    return Dio(
        BaseOptions(baseUrl: baseUrl, headers: {'Accept': 'application/json'}),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = TokenService.token;
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          },
          onError: (error, handler) async {
            if (error.response?.statusCode == 401) {
              await TokenService.clear();
              _unauthorizedController.add(null);
            }
            if (error.response?.statusCode == 423) {
              _enrollmentRequiredController.add(null);
            }
            handler.next(error);
          },
        ),
      );
  }

  static void updateBaseUrl(String url) {
    dio.options.baseUrl = url;
  }

  static String errorMessage(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final errors = data['errors'];

      if (errors is Map<String, dynamic> && errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }
        return firstError.toString();
      }

      if (data['message'] != null) {
        return data['message'].toString();
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
        return "there_is_problem_please_try_again_later";
      default:
        return e.message ?? 'something_went_wrong';
    }
  }
}
