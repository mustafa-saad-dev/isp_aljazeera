import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/forget_password/forgot_password_controller.dart';
import '../../core/localization/app_translations.dart';
import '../../widgets/auth/auth.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ForgotPasswordController>().resetPassword(_password.text);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loading = context.select<ForgotPasswordController, bool>(
      (c) => c.state.isLoading,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: AuthCardShell(
                subtitle: AppTranslations.tr('resetPasswordSubtitle'),
                topBar: const AuthTopActions(),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTextField(
                          controller: _password,
                          label: AppTranslations.tr('newPassword'),
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: scheme.onSurface.withValues(alpha: 0.4),
                              size: 20,
                            ),
                          ),
                          obscureText: _obscure,
                          required: true,
                          validator: (v) => v == null || v.length < 6
                              ? AppTranslations.tr('passwordShort')
                              : null,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          controller: _confirm,
                          label: AppTranslations.tr('confirmPassword'),
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: _obscure,
                          required: true,
                          validator: (v) => v != _password.text
                              ? AppTranslations.tr('passwordMismatch')
                              : null,
                          onSubmitted: (_) => _submit(),
                        ),

                        const SizedBox(height: 40),
                        AppButton(
                          height: 45,
                          label: AppTranslations.tr('resetPassword'),
                          onPressed: _submit,
                          isLoading: loading,
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
