import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/api/api2/api2.dart';
import '../../core/status/request_status.dart';
import '../../models/dashboard/dashboard_widget_model.dart';
import '../../models/home/home_model.dart';
import '../../services/dashboard/dashboard_service.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController() : super(const HomeState());

  final DashboardService _service = DashboardService();

  Future<void> loadDashboard() async {
    emit(state.copyWith(status: RequestStatus.loading, clearMessage: true));

    try {
      final config = await _service.getDashboardConfig();

      final widgets = <int, HomeModel>{};
      for (final w in config.allWidgets) {
        widgets[w.id] = const HomeModel();
      }

      emit(
        state.copyWith(
          status: RequestStatus.success,
          config: config,
          widgetValues: widgets,
        ),
      );

      _fetchWidgetValues(config.allWidgets);
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          message: Api2.errorMessage(e),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, message: e.toString()));
    }
  }

  void _fetchWidgetValues(List<DashboardWidgetModel> widgets) {
    for (final w in widgets) {
      if (w.internalDataSource == null || w.internalDataSource!.isEmpty) {
        continue;
      }
      if (w.dataSource != 'internal') continue;
      _fetchSingleWidget(w);
    }
  }

  Future<void> _fetchSingleWidget(DashboardWidgetModel widget) async {
    try {
      final value = await _service.getWidgetData(widget.internalDataSource!);

      final updated = Map<int, HomeModel>.from(state.widgetValues);
      updated[widget.id] = HomeModel(value: value, loading: false);
      emit(state.copyWith(widgetValues: updated));
    } catch (e) {
      final updated = Map<int, HomeModel>.from(state.widgetValues);
      updated[widget.id] = const HomeModel(value: 0, loading: false);
      emit(state.copyWith(widgetValues: updated));
    }
  }
}
