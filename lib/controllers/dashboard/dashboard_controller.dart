import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/api/api1/api1.dart';
import '../../core/api/api2/api2.dart';
import '../../core/api/api2/api2_endpoint.dart';
import '../../core/status/request_status.dart';
import '../../core/storage/token_service.dart';
import '../../models/dashboard/dashboard_company.dart';
import '../../services/dashboard/dashboard_service.dart';
import 'dashboard_state.dart';

class DashboardController extends Cubit<DashboardState> {
  DashboardController() : super(const DashboardState());

  final DashboardService _service = DashboardService();

  Future<void> getData() async {
    _setupApi2Provider();
    await fetchCompanys();
    await _silentLogin();
    await _fetchApi1Me();
  }

  void _setupApi2Provider() {
    Api2.setCredentialsProvider(() async {
      final company = state.selectedCompany;
      if (company == null) return '';

      Api2Endpoints.baseUrl = company.link;
      Api2.updateBaseUrl(company.link);

      return await _service.login(company: company);
    });
  }

  Future<void> fetchCompanys() async {
    if (isClosed) return;

    emit(state.copyWith(status: RequestStatus.loading, clearMessage: true));

    try {
      return emit(
        state.copyWith(
          status: RequestStatus.success,
          companies: [],
          clearSelected: true,
        ),
      );
      final result = await _service.getCompanys();
      if (isClosed) return;

      if (result.items.isNotEmpty) {
        final selected = state.selectedCompany;
        final updated = selected != null
            ? result.items.where((c) => c.id == selected.id).firstOrNull
            : result.items.first;

        emit(
          state.copyWith(
            status: RequestStatus.success,
            companies: result.items,
            selectedCompany: updated,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: RequestStatus.empty,
            companies: [],
            clearSelected: true,
          ),
        );
      }
    } on DioException catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: RequestStatus.empty,
          message: Api2.errorMessage(e),
          companies: [],
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: RequestStatus.empty,
          message: e.toString(),
          companies: [],
        ),
      );
    }
  }

  Future<void> _silentLogin() async {
    if (isClosed) return;
    if (state.companies.isEmpty) return;
    final company = state.selectedCompany;
    if (company == null) return;

    Api2Endpoints.baseUrl = company.link;
    Api2.updateBaseUrl(company.link);

    try {
      final token = await _service.login(company: company);
      if (isClosed) return;
      if (token.isNotEmpty) {
        TokenService.setApi2(token);
        await _fetchMe();
      }
    } catch (_) {
      // silent fail
    }
  }

  Future<void> _fetchMe() async {
    if (isClosed) return;
    try {
      final authResponse = await _service.getMe();
      if (isClosed) return;
      emit(
        state.copyWith(
          client: authResponse.client,
          permissions: authResponse.permissions,
          features: authResponse.features,
        ),
      );
    } catch (_) {
      // silent fail
    }
  }

  Future<void> _fetchApi1Me() async {
    if (isClosed) return;
    try {
      final response = await _service.getApi1Me();
      if (isClosed) return;
      emit(state.copyWith(api1Permissions: response.permissions));
    } catch (_) {
      // silent fail
    }
  }

  Future<bool> addCompany({
    required String name,
    required String link,
    required String userName,
    required String password,
  }) async {
    if (isClosed) return false;
    emit(state.copyWith(isSubmitting: true, clearMessage: true));

    try {
      DashboardCompany newData = DashboardCompany(
        id: 1,
        name: name,
        link: link,
        username: userName,
        password: password,
      );

      Api2Endpoints.baseUrl = link;
      Api2.updateBaseUrl(link);

      final token = await _service.login(company: newData);
      if (isClosed) return false;

      if (token.isNotEmpty) {
        TokenService.setApi2(token);
        emit(
          state.copyWith(
            status: RequestStatus.success,
            companies: [newData],
            isSubmitting: false,
            selectedCompany: newData,
          ),
        );
        await _fetchMe();
        return true;
      }

      emit(state.copyWith(isSubmitting: false, message: 'login_failed'));
      return false;
    } on DioException catch (e) {
      if (isClosed) return false;
      emit(state.copyWith(isSubmitting: false, message: Api2.errorMessage(e)));
      return false;
    } catch (e) {
      if (isClosed) return false;
      emit(state.copyWith(isSubmitting: false, message: e.toString()));
      return false;
    }
  }

  Future<void> updateCompany({
    required String id,
    required String name,
    required String link,
    required String userName,
    required String password,
  }) async {
    if (isClosed) return;
    emit(state.copyWith(status: RequestStatus.loading, clearMessage: true));

    try {
      await _service.updateCompanys(
        id: id,
        name: name,
        link: link,
        userName: userName,
        password: password,
      );
      if (isClosed) return;
      await fetchCompanys();
    } on DioException catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: RequestStatus.success,
          message: Api1.errorMessage(e),
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(status: RequestStatus.success, message: e.toString()),
      );
    }
  }

  Future<void> removeCompany(String id) async {
    if (isClosed) return;
    emit(state.copyWith(status: RequestStatus.loading, clearMessage: true));

    try {
      await _service.deleteCompanys(id: id);
      if (isClosed) return;
      await fetchCompanys();
    } on DioException catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: RequestStatus.success,
          message: Api1.errorMessage(e),
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(status: RequestStatus.success, message: e.toString()),
      );
    }
  }

  Future<void> selectCompany(DashboardCompany company) async {
    if (isClosed) return;

    Api2Endpoints.baseUrl = company.link;
    Api2.updateBaseUrl(company.link);

    emit(
      state.copyWith(
        selectedCompany: company,
        clearClient: true,
        permissions: [],
        features: [],
      ),
    );

    try {
      final token = await _service.login(company: company);
      if (isClosed) return;
      if (token.isNotEmpty) {
        TokenService.setApi2(token);
        await _fetchMe();
      }
    } catch (_) {}

    emit(state.copyWith(selectedCompany: company));
  }
}
