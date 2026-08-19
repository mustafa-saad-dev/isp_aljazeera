import 'package:flutter/material.dart';
import 'widgets/sidebar/app_sidebar.dart';
import 'widgets/drawer/app_drawer.dart';
import 'widgets/top_bar/app_top_bar.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key, required this.child});

  final Widget child;

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  bool _sidebarCollapsed = false;

  void _toggleSidebar() =>
      setState(() => _sidebarCollapsed = !_sidebarCollapsed);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth >= 900;
    final brightness = Theme.of(context).brightness;
    final contentBg = brightness == Brightness.dark
        ? const Color(0xFF121419)
        : const Color(0xFFEEF0F3);

    if (isWide) {
      return Scaffold(
        body: _WideLayout(
          collapsed: _sidebarCollapsed,
          onToggle: _toggleSidebar,
          contentBg: contentBg,
          child: widget.child,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MY NET',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: ColoredBox(color: contentBg, child: widget.child),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout({
    required this.collapsed,
    required this.onToggle,
    required this.contentBg,
    required this.child,
  });

  final bool collapsed;
  final VoidCallback onToggle;
  final Color contentBg;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sidebar = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: collapsed ? 68 : 240,
      child: AppSidebar(collapsed: collapsed, onToggle: onToggle),
    );

    final content = Expanded(
      child: Column(
        children: [
          AppTopBar(
            onToggleSidebar: onToggle,
            sidebarCollapsed: collapsed,
          ),
          Expanded(
            child: ColoredBox(color: contentBg, child: child),
          ),
        ],
      ),
    );

    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // Arabic (RTL): sidebar on right. English (LTR): sidebar on left.
    if (isRtl) {
      return Row(children: [content, sidebar]);
    }
    return Row(children: [sidebar, content]);
  }
}
