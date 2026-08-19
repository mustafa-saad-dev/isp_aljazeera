import 'dart:async';
import 'package:dio/dio.dart';

import '../../encryption/aes_encryption_service.dart';
import '../../storage/token_service.dart';
import 'api2_endpoint.dart';

class Api2 {
  Api2._();

  // ── Dio instance (auto encrypt/decrypt) ──
  static final Dio dio = _create();

  // ── Streams ──
  static final StreamController<void> _unauthorizedController =
      StreamController<void>.broadcast();
  static Stream<void> get onUnauthorized => _unauthorizedController.stream;

  static final StreamController<void> _enrollmentRequiredController =
      StreamController<void>.broadcast();
  static Stream<void> get onEnrollmentRequired =>
      _enrollmentRequiredController.stream;

  static Dio _create() {
    return Dio(
        BaseOptions(
          baseUrl: Api2Endpoints.baseUrl,
          headers: {'Accept': 'application/json'},
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final rawToken = TokenService.getApi2Token();
            if (rawToken.isNotEmpty) {
              final decryptedToken =
                  AesEncryptionService.decryptToken(rawToken);
              options.headers['Authorization'] = 'Bearer $decryptedToken';
            }

            if (options.data is Map<String, dynamic>) {
              options.data = AesEncryptionService.encryptBody(options.data);
            }

            handler.next(options);
          },
          onResponse: (response, handler) async {
            if (response.data is Map<String, dynamic> ||
                response.data is String) {
              try {
                response.data =
                    AesEncryptionService.decryptResponse(response.data);
              } catch (_) {}
            }
            handler.next(response);
          },
          onError: (error, handler) async {
            if (error.response?.statusCode == 401) {
              await TokenService.clearApi2();
              _unauthorizedController.add(null);
            }
            if (error.response?.statusCode == 423) {
              _enrollmentRequiredController.add(null);
            }
            if (error.response?.data is Map<String, dynamic> ||
                error.response?.data is String) {
              try {
                error.response!.data =
                    AesEncryptionService.decryptResponse(
                        error.response!.data);
              } catch (_) {}
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
