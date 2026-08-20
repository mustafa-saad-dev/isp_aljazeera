import '../../core/api/api2/api2.dart';
import '../../core/api/api2/api2_endpoint.dart';
import '../../core/encryption/aes_encryption_service.dart';

import '../../core/api/api1/api1.dart';
import '../../core/api/api1/api1_endpoint.dart';
import '../../core/helpers/pagination_helper.dart';
import '../../models/dashboard/api1_auth_response.dart';
import '../../models/dashboard/api_client.dart';
import '../../models/dashboard/dashboard_company.dart';
import '../../models/dashboard/dashboard_config.dart';

class DashboardService {
  DashboardService();

  Future<String> login({required DashboardCompany company}) async {
    var data = {"username": company.username, "password": company.password};
    final response = await Api2.dio.post(
      Api2Endpoints.login,
      data: AesEncryptionService.encryptBody(data),
    );
    return response.data['token'] ?? '';
  }

  Future<DashboardConfig> getDashboardConfig() async {
    final response = await Api2.dio.get(Api2Endpoints.dashboard);
    return DashboardConfig.fromJson(response.data);
  }

  Future<AuthClientResponse> getMe() async {
    final response = await Api2.dio.get(Api2Endpoints.me);
    return AuthClientResponse.fromJson(response.data);
  }

  Future<int> getWidgetData(String source) async {
    final response = await Api2.dio.get(Api2Endpoints.widgetData(source));

    final data = response.data['data'];

    if (data is num) return data.toInt();
    if (data is String) return int.tryParse(data) ?? 0;
    return 0;
  }

  Future<PaginatedResult<DashboardCompany>> getCompanys({int page = 1}) async {
    final response = await Api1.dio.get(
      Api1Endpoints.getCompanys,
      queryParameters: {'page': page},
    );
    return PaginatedResult.fromJson(response.data, DashboardCompany.fromJson);
  }

  Future<DashboardCompany> addCompany({
    required String name,
    required String link,
    required String userName,
    required String password,
  }) async {
    final response = await Api1.dio.post(
      Api1Endpoints.addCompany,
      data: {
        'name': name,
        'link': link,
        'username': userName,
        'password': password,
      },
    );
    return DashboardCompany.fromJson(response.data);
  }

  Future<void> updateCompanys({
    required String id,
    required String name,
    required String link,
    required String userName,
    required String password,
  }) async {
    await Api1.dio.put(
      '${Api1Endpoints.getCompanys}/$id',
      data: {
        'name': name,
        'link': link,
        'username': userName,
        'password': password,
      },
    );
  }

  Future<void> deleteCompanys({required String id}) async {
    await Api1.dio.delete('${Api1Endpoints.getCompanys}/$id');
  }

  Future<Api1AuthResponse> getApi1Me() async {
    final response = await Api1.dio.get(Api1Endpoints.me);
    return Api1AuthResponse.fromJson(response.data);
  }
}
