import 'package:flutter/material.dart';

import 'package:isp_aljazeera/core/theme/tokens/app_brand.dart';

/// بطاقة مساحة عمل داخل الشاشة الرئيسية (خاصّة بشاشة واحدة).
class SpaceTile extends StatelessWidget {
  const SpaceTile({
    super.key,
    required this.title,
    required this.icon,
    required this.count,
  });

  final String title;
  final IconData icon;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: AppBrand.brand),
            const SizedBox(height: 12),
            Text(
              count,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
