import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toastification/toastification.dart';
import 'controllers/auth/auth_controller.dart';
import 'controllers/locale/locale_controller.dart';
import 'controllers/theme/theme_controller.dart';
import 'core/device/device_info_service.dart';
import 'core/localization/app_translations.dart';
import 'core/pwa/pwa_install.dart';
import 'core/routes/app_router.dart';
import 'core/storage/token_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    AppTranslations.load(),
    DeviceInfoService.load(),
    TokenService.init(),
  ]);

  await PwaInstall.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthController()..loadSession()),
        BlocProvider(create: (_) => LocaleController()..loadSavedLocale()),
        BlocProvider(create: (_) => ThemeController()..loadSavedTheme()),
      ],
      child: _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final localeState = context.watch<LocaleController>().state;
    final themeState = context.watch<ThemeController>().state;
    return ToastificationWrapper(
      child: SafeArea(
        top: false,
        child: MaterialApp.router(
          title: AppTranslations.tr('appName'),
          debugShowCheckedModeBanner: false,
          locale: localeState.locale,
          supportedLocales: AppTranslations.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeState.mode,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
