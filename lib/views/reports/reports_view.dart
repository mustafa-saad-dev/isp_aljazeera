import 'package:flutter/material.dart';

import 'package:isp_aljazeera/core/localization/app_translations.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppTranslations.tr;
    return Scaffold(
      appBar: AppBar(title: Text(tr('reports'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.bar_chart_outlined),
              title: Text(tr('monthlyPerf')),
              subtitle: Text(tr('jan2026')),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.pie_chart_outline),
              title: Text(tr('revenueReport')),
              subtitle: Text(tr('q1_2026')),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people_alt_outlined),
              title: Text(tr('newClients')),
              subtitle: Text(tr('clientsCount')),
            ),
          ),
        ],
      ),
    );
  }
}
