import 'package:flutter/material.dart';

class AuthLinkText extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  const AuthLinkText({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: Colors.transparent,
      ),
      child: Text(
        label,
        style: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: scheme.primary,
        ),
      ),
    );
  }
}
