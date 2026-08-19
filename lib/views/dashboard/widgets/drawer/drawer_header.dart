import 'package:flutter/material.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      color: scheme.surface,
      child: Row(
        children: [
          Icon(Icons.wifi, color: scheme.primary, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'MY NET',
              style: TextStyle(
                color: scheme.primary,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: scheme.onSurface.withValues(alpha: 0.5),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
