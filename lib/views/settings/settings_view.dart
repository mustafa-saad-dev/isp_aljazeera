import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:isp_aljazeera/controllers/auth/auth_controller.dart';
import 'package:isp_aljazeera/core/localization/app_translations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.select<AuthController, UserModel?>(
    //   (c) => c.state.user,
    // );

    return Scaffold(
      appBar: AppBar(title: Text(AppTranslations.tr('settings'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ListTile(
          //   leading: const Icon(Icons.person_outline),
          //   title: Text(user?.name ?? '—'),
          //   subtitle: Text(user?.email ?? user?.phone ?? ''),
          // ),
          const Divider(),

          // BlocBuilder<LanguageCubit, Locale>(
          //   builder: (context, locale) => ListTile(
          //     leading: const Icon(Icons.language_outlined),
          //     title: Text(AppTranslations.tr('language')),
          //     trailing: DropdownButton<Locale>(
          //       value: locale,
          //       underline: const SizedBox.shrink(),
          //       items: [
          //         DropdownMenuItem(
          //           value: const Locale('ar'),
          //           child: Text(AppTranslations.tr('arabic')),
          //         ),
          //         DropdownMenuItem(
          //           value: const Locale('en'),
          //           child: Text(AppTranslations.tr('english')),
          //         ),
          //         DropdownMenuItem(
          //           value: const Locale('ku'),
          //           child: Text(AppTranslations.tr('kurdish')),
          //         ),
          //       ],
          //       onChanged: (l) {
          //         if (l != null) context.read<LanguageCubit>().change(l);
          //       },
          //     ),
          //   ),
          // ),
          // BlocBuilder<ThemeModeCubit, ThemeMode>(
          //   builder: (context, mode) => ListTile(
          //     leading: const Icon(Icons.brightness_6_outlined),
          //     title: Text(AppTranslations.tr('theme')),
          //     trailing: DropdownButton<ThemeMode>(
          //       value: mode,
          //       underline: const SizedBox.shrink(),
          //       items: [
          //         DropdownMenuItem(
          //           value: ThemeMode.light,
          //           child: Text(AppTranslations.tr('light')),
          //         ),
          //         DropdownMenuItem(
          //           value: ThemeMode.dark,
          //           child: Text(AppTranslations.tr('dark')),
          //         ),
          //         DropdownMenuItem(
          //           value: ThemeMode.system,
          //           child: Text(AppTranslations.tr('system')),
          //         ),
          //       ],
          //       onChanged: (m) {
          //         if (m != null) context.read<ThemeModeCubit>().change(m);
          //       },
          //     ),
          //   ),
          // ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.cloud_outlined),
            title: Text(AppTranslations.tr('sasradiusTitle')),
            subtitle: Text(AppTranslations.tr('sasradiusSubtitle')),
            trailing: const Icon(Icons.chevron_right),
          ),
          // if (kIsWeb)
          //   ValueListenableBuilder<bool>(
          //     valueListenable: PwaInstall.notifier,
          //     builder: (context, canInstall, _) {
          //       if (!canInstall) return const SizedBox.shrink();
          //       return ListTile(
          //         leading: const Icon(Icons.install_mobile_outlined),
          //         title: Text(AppTranslations.tr('pwa')),
          //         subtitle: Text(AppTranslations.tr('pwaInstallHint')),
          //         trailing: FilledButton(
          //           onPressed: () => PwaInstall.install(),
          //           child: Text(AppTranslations.tr('install')),
          //         ),
          //       );
          //     },
          //   ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text(AppTranslations.tr('notifications')),
            subtitle: Text(AppTranslations.tr('firebaseNotifications')),
            trailing: Switch(value: true, onChanged: (_) {}),
          ),
          const SizedBox(height: 16),
          FilledButton.tonal(
            onPressed: () => context.read<AuthController>().logout(),
            child: Text(AppTranslations.tr('logout')),
          ),
        ],
      ),
    );
  }
}
