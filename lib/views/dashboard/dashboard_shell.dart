import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../controllers/dashboard/dashboard_controller.dart';
import '../../core/navigation/nav_config.dart';
import '../../core/status/request_status.dart';
import '../../core/theme/app_theme.dart';
import '../dashboard/widgets/add_company_dialog.dart';
import '../dashboard/widgets/company_selector.dart';
import '../../widgets/status/status_view.dart';
import 'app_drawer.dart';
import 'app_sidebar.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key, required this.child});

  final Widget child;

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell>
    with TickerProviderStateMixin {
  bool _sidebarCollapsed = false;
  bool _dialogShowing = false;
  late final DashboardController _dashboardController;

  late final AnimationController _entranceCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _dashboardController = DashboardController()..getData();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0.08, 0.0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entranceCtrl,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
          ),
        );
    _scaleAnim = Tween<double>(begin: 0.97, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _dashboardController.close();
    _entranceCtrl.dispose();
    super.dispose();
  }

  void _toggleSidebar() =>
      setState(() => _sidebarCollapsed = !_sidebarCollapsed);

  void _showForceDialog(BuildContext context) {
    _dialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (_) => BlocProvider.value(
        value: context.read<DashboardController>(),
        child: AddCompanyDialog(onAdded: () => _dialogShowing = false),
      ),
    ).whenComplete(() => _dialogShowing = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final scheme = context.colorScheme;
    final contentBg = scheme.surface;

    return BlocProvider.value(
      value: _dashboardController,
      child: Builder(
        builder: (context) {
          final state = context.watch<DashboardController>().state;
          final isWide = screenWidth >= 900;
          final isEmpty = state.companies.isEmpty;

          if (state.status == RequestStatus.success && isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && !_dialogShowing) {
                _showForceDialog(context);
              }
            });
          }

          if (isWide) {
            return Scaffold(
              backgroundColor: scheme.surface,
              body: StatusView(
                status: state.status,
                isEmpty: isEmpty,
                onRetry: () => _dashboardController.getData(),
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: _WideLayout(
                    collapsed: _sidebarCollapsed,
                    onToggle: _toggleSidebar,
                    contentBg: contentBg,
                    slideAnim: _slideAnim,
                    scaleAnim: _scaleAnim,
                    child: widget.child,
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: contentBg,
            appBar: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedMenu07,
                    size: 22,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              title: Text(
                NavConfig.titleForLocation(
                  GoRouterState.of(context).matchedLocation,
                ),
                style: context.typography.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
              centerTitle: false,
              backgroundColor: scheme.surface,
              foregroundColor: scheme.onSurface,
              elevation: 0,
              actions: const [CompanySelector(), SizedBox(width: 12)],
            ),
            drawer: const AppDrawer(),
            body: StatusView(
              status: state.status,
              isEmpty: isEmpty,
              onRetry: () => _dashboardController.getData(),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: ColoredBox(color: contentBg, child: widget.child),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout({
    required this.collapsed,
    required this.onToggle,
    required this.contentBg,
    required this.slideAnim,
    required this.scaleAnim,
    required this.child,
  });

  final bool collapsed;
  final VoidCallback onToggle;
  final Color contentBg;
  final Animation<Offset> slideAnim;
  final Animation<double> scaleAnim;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final borderColor = Theme.of(context).dividerColor;
    final sidebar = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: collapsed ? 68 : 240,
      child: AppSidebar(collapsed: collapsed, onToggle: onToggle),
    );

    final content = Expanded(
      child: Column(
        children: [
          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: scheme.surface,
              border: Border(bottom: BorderSide(color: borderColor)),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: onToggle,
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedMenu07,
                    size: 22,
                    color: scheme.onSurface,
                  ),
                  splashRadius: 18,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    NavConfig.titleForLocation(
                      GoRouterState.of(context).matchedLocation,
                    ),
                    style: textTheme.bodyMedium,
                  ),
                ),

                const CompanySelector(),
              ],
            ),
          ),
          Expanded(
            child: ScaleTransition(
              scale: scaleAnim,
              child: ColoredBox(color: contentBg, child: child),
            ),
          ),
        ],
      ),
    );

    return Row(children: [sidebar, content]);
  }
}
