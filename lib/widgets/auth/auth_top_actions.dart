import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isp_aljazeera/core/theme/app_theme.dart';

import '../../controllers/locale/locale_controller.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../core/localization/app_translations.dart';

class AuthTopActions extends StatelessWidget {
  const AuthTopActions({super.key});

  @override
  Widget build(BuildContext context) {
    final localeState = context.watch<LocaleController>().state;
    final themeState = context.watch<ThemeController>().state;
    return Row(
      children: [
        _AuthDropdown<String>(
          icon: Icons.language_rounded,
          label: localeState.langName,
          items: [
            _DropdownItem(value: 'ar', label: 'العربية'),
            _DropdownItem(value: 'en', label: 'English'),
            _DropdownItem(value: 'ku', label: 'کوردی'),
          ],
          selected: localeState.locale.languageCode,
          onSelected: (v) =>
              context.read<LocaleController>().selectAndFinishFirstLaunch(v),
        ),
        const Spacer(),
        _AuthDropdown<String>(
          icon: themeState.mode == ThemeMode.dark
              ? Icons.dark_mode_outlined
              : themeState.mode == ThemeMode.light
              ? Icons.light_mode_outlined
              : Icons.brightness_auto_outlined,
          label: themeState.themeName,
          items: [
            _DropdownItem(
              value: 'light',
              label: AppTranslations.tr('lightMode'),
            ),
            _DropdownItem(value: 'dark', label: AppTranslations.tr('darkMode')),
            _DropdownItem(
              value: 'system',
              label: AppTranslations.tr('systemMode'),
            ),
          ],
          selected: themeState.themeName,
          onSelected: (v) {
            final mode = v == 'dark'
                ? ThemeMode.dark
                : v == 'light'
                ? ThemeMode.light
                : ThemeMode.system;
            context.read<ThemeController>().toggleTheme(mode);
          },
        ),
      ],
    );
  }
}

class _DropdownItem<T> {
  final T value;
  final String label;
  final Color? swatch;

  const _DropdownItem({required this.value, required this.label, this.swatch});
}

class _AuthDropdown<T> extends StatefulWidget {
  const _AuthDropdown({
    required this.icon,
    required this.label,
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  final IconData icon;
  final String label;
  final List<_DropdownItem<T>> items;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  State<_AuthDropdown<T>> createState() => _AuthDropdownState<T>();
}

class _AuthDropdownState<T> extends State<_AuthDropdown<T>> {
  final GlobalKey _buttonKey = GlobalKey();
  bool _isOpen = false;
  OverlayEntry? _overlay;

  @override
  void dispose() {
    _overlay?.remove();
    _overlay = null;
    super.dispose();
  }

  void _removeOverlay() {
    _overlay?.remove();
    _overlay = null;
    if (mounted) setState(() => _isOpen = false);
  }

  void _toggle() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showMenu();
    }
  }

  void _showMenu() {
    final renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    _overlay = OverlayEntry(
      builder: (ctx) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            top: offset.dy + size.height + 8,
            left: Directionality.of(context) == TextDirection.rtl
                ? null
                : offset.dx,
            right: Directionality.of(context) == TextDirection.rtl
                ? MediaQuery.of(context).size.width - offset.dx - size.width
                : null,
            child: _DropdownMenu<T>(
              items: widget.items,
              selected: widget.selected,
              scheme: scheme,
              textTheme: textTheme,
              onSelected: (v) {
                _removeOverlay();
                widget.onSelected(v);
              },
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlay!);
    setState(() => _isOpen = true);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        key: _buttonKey,
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: _isOpen
              ? scheme.onSurface.withValues(alpha: 0.08)
              : scheme.onSurface.withValues(alpha: 0.05),
          borderRadius: AppRadius.mediumAll,
          border: Border.all(
            color: _isOpen
                ? scheme.primary.withValues(alpha: 0.4)
                : scheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, size: 15, color: scheme.primary),
            const SizedBox(width: 7),
            Text(
              AppTranslations.tr(widget.label),
              style: textTheme.labelSmall?.copyWith(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(width: 5),
            AnimatedRotation(
              turns: _isOpen ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 15,
                color: scheme.onSurface.withValues(alpha: 0.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownMenu<T> extends StatelessWidget {
  const _DropdownMenu({
    required this.items,
    required this.selected,
    required this.scheme,
    required this.textTheme,
    required this.onSelected,
  });

  final List<_DropdownItem<T>> items;
  final T selected;
  final ColorScheme scheme;
  final TextTheme textTheme;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        builder: (ctx, t, child) {
          return Opacity(
            opacity: t,
            child: Transform.translate(
              offset: Offset(0, -8 + 8 * t),
              child: Transform.scale(
                scale: 0.95 + 0.05 * t,
                alignment: AlignmentDirectional.topStart,
                child: child,
              ),
            ),
          );
        },
        child: Container(
          constraints: const BoxConstraints(maxWidth: 150),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: AppRadius.mediumAll,
            border: Border.all(color: scheme.onSurface.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: scheme.brightness == Brightness.dark ? 0.35 : 0.12,
                ),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: items.map((item) {
              final isActive = item.value == selected;
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onSelected(item.value),
                  borderRadius: AppRadius.smallAll,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 8.5,
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          item.label,
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: scheme.onSurface,
                          ),
                        ),
                        Spacer(),
                        if (isActive)
                          Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: scheme.primary,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
