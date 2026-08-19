import 'package:flutter/material.dart';

import '../../../../../core/localization/app_translations.dart';

class RevenueChart extends StatelessWidget {
  const RevenueChart({super.key});

  static const _days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  static const _values = [6.0, 3.0, 8.0, 10.0, 5.0, 9.0, 5.0];
  static const _maxValue = 10.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    final border =
        brightness == Brightness.dark ? const Color(0xFF2A2D35) : const Color(0xFFEDF0F3);
    final titleColor =
        brightness == Brightness.dark ? const Color(0xFFE5E7EB) : const Color(0xFF374151);
    final valueColor =
        brightness == Brightness.dark ? const Color(0xFF9CA3AF) : const Color(0xFF374151);
    final barFill =
        brightness == Brightness.dark ? const Color(0xFF6366F1) : const Color(0xFF4338CA);

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
            AppTranslations.tr('revenueTrend'),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barWidth =
                    (constraints.maxWidth / 7).clamp(8.0, 36.0);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (i) {
                    final fraction = _values[i] / _maxValue;
                    final maxBarH = constraints.maxHeight - 24;
                    final barH = fraction * maxBarH;

                    return Expanded(
                      child: Center(
                        child: SizedBox(
                          width: barWidth,
                          height: maxBarH + 24,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _values[i].toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 9,
                                  color: valueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: barFill,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    height: barH.clamp(4.0, maxBarH),
                                    width: barWidth,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _days[i],
                                style: TextStyle(
                                  fontSize: 9,
                                  color: valueColor.withValues(alpha: 0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
