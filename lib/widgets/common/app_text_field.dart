import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';
import '../../core/localization/app_translations.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final int maxLines;
  final void Function(String)? onSubmitted;
  final bool required;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.maxLines = 1,
    this.onSubmitted,
    this.required = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.typography;
    final scheme = context.colorScheme;

    final effectiveInputFormatters =
        keyboardType == TextInputType.number ||
            keyboardType == TextInputType.phone
        ? [FilteringTextInputFormatter.digitsOnly]
        : null;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      inputFormatters: effectiveInputFormatters,
      validator: (v) {
        if (validator != null) return validator!(v);
        if (required && (v == null || v.trim().isEmpty)) {
          return AppTranslations.tr('requiredField');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurface.withValues(alpha: 0.45),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: scheme.onSurface.withValues(alpha: 0.35),
          size: 20,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: scheme.onSurface.withValues(alpha: 0.04),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: scheme.onSurface.withValues(alpha: 0.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
      ),
    );
  }
}
