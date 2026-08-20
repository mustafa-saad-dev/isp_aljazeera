import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/dashboard/dashboard_controller.dart';
import '../../../controllers/dashboard/dashboard_state.dart';
import '../../../core/localization/app_translations.dart';
import 'add_company_dialog.dart';

class CompanySelector extends StatelessWidget {
  const CompanySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final typo = Theme.of(context).textTheme;

    return BlocBuilder<DashboardController, DashboardState>(
      builder: (context, state) {
        final selected = state.selectedCompany;

        return PopupMenuButton<int>(
          offset: const Offset(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (id) {
            if (id == -1) {
              AddCompanyDialog.show(context);
            } else {
              final company = state.companies
                  .where((c) => c.id == id)
                  .firstOrNull;
              if (company != null) {
                context.read<DashboardController>().selectCompany(company);
              }
            }
          },
          itemBuilder: (_) => [
            ...state.companies.map(
              (c) => PopupMenuItem(
                value: c.id,
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: c.id == selected?.id
                            ? scheme.primary.withValues(alpha: 0.12)
                            : scheme.onSurface.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          c.name.isNotEmpty ? c.name[0].toUpperCase() : '?',
                          style: typo.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: c.id == selected?.id
                                ? scheme.primary
                                : scheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.name,
                            style: typo.bodySmall?.copyWith(
                              fontWeight: c.id == selected?.id
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            c.link,
                            style: typo.bodySmall?.copyWith(
                              fontSize: 10,
                              color: scheme.onSurface.withValues(alpha: 0.4),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (c.id == selected?.id)
                      Icon(Icons.check_circle, size: 16, color: scheme.primary),
                  ],
                ),
              ),
            ),
            if (state.companies.isNotEmpty) const PopupMenuDivider(height: 1),
            PopupMenuItem(
              value: -1,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add, size: 16, color: scheme.primary),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppTranslations.tr('addProvider'),
                    style: typo.bodySmall?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color: scheme.onSurface.withValues(alpha: 0.1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      selected != null && selected.name.isNotEmpty
                          ? selected.name[0].toUpperCase()
                          : '?',
                      style: typo.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 120),
                  child: Text(
                    selected?.name ?? AppTranslations.tr('noProviders'),
                    style: typo.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: scheme.onSurface.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
