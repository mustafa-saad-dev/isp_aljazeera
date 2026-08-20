import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/forget_password/forgot_password_controller.dart';
import '../../controllers/forget_password/forgot_password_state.dart';
import '../../core/localization/app_translations.dart';
import '../../core/routes/app_routes.dart';
import '../../core/toast/app_toast.dart';
import 'forget_password_view.dart';
import 'otp_verify_view.dart';
import 'reset_password_view.dart';

class ForgetPasswordFlow extends StatelessWidget {
  const ForgetPasswordFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordController(),
      child: BlocListener<ForgotPasswordController, ForgotPasswordState>(
        listenWhen: (p, c) => c.isError || c.isOffline || c.step >= 2,
        listener: (context, state) {
          if (state.isError || state.isOffline) {
            AppToast.error(context, state.message ?? '');
          } else if (state.step == 4) {
            AppToast.success(
              context,
              AppTranslations.tr('passwordResetSuccess'),
            );
            context.go(AppRoutes.login);
          }
        },
        child: BlocBuilder<ForgotPasswordController, ForgotPasswordState>(
          builder: (context, state) {
            switch (state.step) {
              case 2:
                return const OtpVerifyView();
              case 3:
                return const ResetPasswordView();
              default:
                return const ForgetPasswordView();
            }
          },
        ),
      ),
    );
  }
}
