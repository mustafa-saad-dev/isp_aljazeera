import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/common/app_logo.dart';
import '../../controllers/dashboard/dashboard_controller.dart';
import '../../controllers/home/home_controller.dart';
import '../../controllers/home/home_state.dart';
import '../../core/helpers/dashboard_widget_mapper.dart';
import '../../core/helpers/widget_url_mapper.dart';
import '../../core/localization/app_translations.dart';
import '../../models/dashboard/dashboard_widget_model.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/status/status_view.dart';

class DashboardHomePage extends StatefulWidget {
  const DashboardHomePage({super.key});

  @override
  State<DashboardHomePage> createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController()..loadDashboard();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _controller,
      child: BlocBuilder<HomeController, HomeState>(
        builder: (context, state) {
          return StatusView(
            status: state.status,
            isEmpty: state.config == null,
            onRetry: () => _controller.loadDashboard(),
            child: _DashboardContent(state: state),
          );
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final config = state.config;
    if (config == null) return const SizedBox.shrink();

    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context, isDark)),
          if (config.alert.enabled)
            SliverToBoxAdapter(
              child: _buildAlertBanner(context, config, isDark),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            sliver: SliverList.separated(
              itemCount: config.rows.length,
              separatorBuilder: (_, _) => const SizedBox(height: 20),
              itemBuilder: (context, rowIndex) {
                final row = config.rows[rowIndex];
                return _buildRow(context, row.widgets, state, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    final client = context.watch<DashboardController>().state.client;
    final greeting = _getGreeting();
    final name = client?.fullName.isNotEmpty == true
        ? client!.fullName
        : AppTranslations.tr('dashboard');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1D24) : const Color(0xFFF8F9FB),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greeting,',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF111827),
              letterSpacing: -0.3,
            ),
          ),
          Center(child: AppLogo(size: 250)),
        ],
      ),
    );
  }

  Widget _buildAlertBanner(BuildContext context, dynamic config, bool isDark) {
    final alert = config.alert;
    final alertColor = switch (alert.type) {
      'warning' => const Color(0xFFF59E0B),
      'danger' => const Color(0xFFEF4444),
      'success' => const Color(0xFF10B981),
      _ => const Color(0xFF3B82F6),
    };

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: alertColor.withValues(alpha: isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: alertColor.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 20, color: alertColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              alert.text ?? '',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: alertColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    List<DashboardWidgetModel> widgets,
    HomeState state,
    bool isDark,
  ) {
    if (widgets.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < widgets.length; i++) ...[
                if (i > 0) const SizedBox(width: 16),
                Expanded(
                  flex: widgets[i].widthFlex,
                  child: _buildWidget(context, widgets[i], state, isDark),
                ),
              ],
            ],
          );
        }

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: widgets
              .map(
                (w) => SizedBox(
                  width: widgets.length >= 3
                      ? (constraints.maxWidth - 16) / 2
                      : constraints.maxWidth,
                  child: _buildWidget(context, w, state, isDark),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildWidget(
    BuildContext context,
    DashboardWidgetModel widget,
    HomeState state,
    bool isDark,
  ) {
    final homeModel = state.widgetValues[widget.id];
    final value = homeModel?.value ?? 0;
    final loading = homeModel?.loading ?? true;

    final color = DashboardWidgetMapper.color(widget.color, isDark: isDark);
    final icon = DashboardWidgetMapper.icon(widget.icon);
    final label = AppTranslations.tr('widget_title_${widget.title}');

    return StatCard(
      value: loading ? '—' : _formatNumber(value),
      label: label.isNotEmpty ? label : widget.title,
      icon: icon,
      color: color,
      onTap: widget.url != null
          ? () => WidgetUrlMapper.navigate(context, widget.url)
          : null,
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return AppTranslations.tr('morning');
    if (hour < 17) return AppTranslations.tr('afternoon');
    return AppTranslations.tr('evening');
  }

  String _formatNumber(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toString();
  }
}
