import 'package:flutter/material.dart';

import '../../../../core/localization/app_translations.dart';
import 'widgets/stat_card.dart';
import 'widgets/revenue_chart.dart';

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final crossCount = screenWidth > 1200 ? 4 : (screenWidth > 900 ? 3 : 2);
    final brightness = Theme.of(context).brightness;
    final border =
        brightness == Brightness.dark ? const Color(0xFF2A2D35) : const Color(0xFFEDF0F3);
    final titleColor =
        brightness == Brightness.dark ? const Color(0xFFE5E7EB) : const Color(0xFF374151);
    final labelColor =
        brightness == Brightness.dark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: crossCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.45,
              children: [
                StatCard(
                  value: '2,000',
                  label: AppTranslations.tr('todaySales'),
                  icon: Icons.wifi,
                  color: const Color(0xFF5C6FC0),
                ),
                StatCard(
                  value: '1,200',
                  label: AppTranslations.tr('activeSubscribers'),
                  icon: Icons.people_alt_outlined,
                  color: const Color(0xFF4CAF72),
                ),
                StatCard(
                  value: '200',
                  label: AppTranslations.tr('todayOperations'),
                  icon: Icons.receipt_long_outlined,
                  color: const Color(0xFF29A3CD),
                ),
                StatCard(
                  value: '14',
                  label: AppTranslations.tr('expiredSubscribers'),
                  icon: Icons.event_busy_outlined,
                  color: const Color(0xFFEF5F5F),
                ),
                StatCard(
                  value: '5',
                  label: AppTranslations.tr('lowStock'),
                  icon: Icons.inventory_2_outlined,
                  color: const Color(0xFFF0B429),
                ),
                StatCard(
                  value: '0',
                  label: AppTranslations.tr('agentDebts'),
                  icon: Icons.monetization_on_outlined,
                  color: const Color(0xFFEC6A95),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 500) {
                    return const Column(
                      children: [Expanded(child: RevenueChart())],
                    );
                  }
                  return Row(
                    children: [
                      const Expanded(flex: 3, child: RevenueChart()),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: _SalesDistribution(
                          border: border,
                          titleColor: titleColor,
                          labelColor: labelColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesDistribution extends StatelessWidget {
  const _SalesDistribution({
    required this.border,
    required this.titleColor,
    required this.labelColor,
  });
  final Color border;
  final Color titleColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTranslations.tr('salesDistribution'),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 20),
          _LegendRow(
            color: const Color(0xFF5C6FC0),
            label: AppTranslations.tr('subscription'),
            value: '40%',
            labelColor: labelColor,
          ),
          const SizedBox(height: 12),
          _LegendRow(
            color: const Color(0xFF4CAF72),
            label: AppTranslations.tr('device'),
            value: '60%',
            labelColor: labelColor,
          ),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.color,
    required this.label,
    required this.value,
    required this.labelColor,
  });
  final Color color;
  final String label;
  final String value;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label,
              style: TextStyle(fontSize: 12, color: labelColor)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: labelColor.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
