// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/auth/auth_state.dart';
import '../../controllers/splash/splash_controller.dart';
import '../../controllers/splash/splash_state.dart';
import '../../core/routes/app_routes.dart';
import '../../services/app_update/app_update_service.dart';
import '../../core/status/request_status.dart';
import '../../views/splash/widgets/splash_loading.dart';
import '../../views/splash/widgets/splash_update_dialog.dart';
import '../../widgets/status/status_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _alertOpen = false;
  bool _navigated = false;
  bool _splashReady = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashController()..start(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<SplashController, SplashState>(
            listener: _onSplashStateChanged,
          ),
          BlocListener<AuthController, AuthState>(
            listener: (context, state) => _tryNavigate(context),
          ),
        ],
        child: BlocBuilder<SplashController, SplashState>(
          builder: (context, state) {
            if (state.status == RequestStatus.loading) {
              return const SplashLoading();
            }
            return StatusView(
              status: state.status,
              onRetry: () => context.read<SplashController>().start(),
              child: const SplashLoading(),
            );
          },
        ),
      ),
    );
  }

  void _onSplashStateChanged(BuildContext context, SplashState state) {
    if (!mounted || _navigated) return;

    if (state.update != null && state.updateRequired) {
      _showAlert(context, update: state.update!, forced: true);
    } else if (state.update != null && !state.updateRequired) {
      _showAlert(context, update: state.update!, forced: false);
    } else if (state.isReady) {
      _splashReady = true;
      _tryNavigate(context);
    }
  }

  Future<void> _showAlert(
    BuildContext context, {
    required UpdateInfo update,
    required bool forced,
  }) async {
    if (_alertOpen || !mounted) return;
    _alertOpen = true;

    await SplashUpdateDialog.show(
      context,
      update: update,
      forced: forced,
      onUpdate: update.downloadUrl.isNotEmpty
          ? () => AppUpdateService.openUpdateUrl(update.downloadUrl)
          : null,
    );

    if (!mounted) return;
    _alertOpen = false;
    _splashReady = true;
    _tryNavigate(context);
  }

  void _tryNavigate(BuildContext context) {
    if (!mounted || _navigated || !_splashReady || _alertOpen) return;

    final auth = context.read<AuthController>().state;
    if (auth.status == RequestStatus.loading ||
        auth.status == RequestStatus.initial) {
      return;
    }

    _navigated = true;
    context.go(auth.user != null ? AppRoutes.home : AppRoutes.login);
  }
}
