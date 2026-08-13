import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:isp_aljazeera/controllers/auth/auth_controller.dart';
import 'package:isp_aljazeera/controllers/auth/auth_state.dart';
import 'package:isp_aljazeera/core/helpers/toast_helper.dart';
import 'package:isp_aljazeera/core/localization/app_translations.dart';
import 'package:isp_aljazeera/core/routes/app_routes.dart';
import 'package:isp_aljazeera/core/theme/app_theme.dart';
import 'package:isp_aljazeera/models/auth/register_model.dart';
import 'package:isp_aljazeera/widgets/common/app_button.dart';
import 'package:isp_aljazeera/widgets/common/app_logo.dart';
import 'package:isp_aljazeera/widgets/common/app_text_field.dart';
import 'package:isp_aljazeera/widgets/common/social_buttons.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final identifier = _email.text.trim().isNotEmpty
        ? _email.text.trim()
        : _phone.text.trim();
    context.read<AuthController>().register(
          RegisterRequest(
            name: _name.text.trim(),
            identifier: identifier,
            password: _password.text,
            email: _email.text.trim().isNotEmpty ? _email.text.trim() : '',
            phone: _phone.text.trim().isNotEmpty ? _phone.text.trim() : '',
          ),
        );
  }

  void _socialLogin(String provider) {
    ToastHelper.showInfo(
      context,
      AppTranslations.tr('socialNotAvailable').replaceAll('{provider}', provider),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final colors = context.colors;

    return Scaffold(
      body: BlocConsumer<AuthController, AuthState>(
        listenWhen: (p, c) => c.isError || c.isOffline || c.registered,
        listener: (context, state) {
          if (state.registered) {
            ToastHelper.showSuccess(context, AppTranslations.tr('registerSuccess'));
            context.go(AppRoutes.login);
          } else if (state.isError || state.isOffline) {
            ToastHelper.showError(context, state.message ?? '');
          }
        },
        builder: (context, state) {
          final loading = state.isLoading;
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [scheme.surface, colors.info.withValues(alpha: 0.05)],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Container(
                      padding: const EdgeInsets.all(34),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: AppTheme.largeRadius,
                        border: Border.all(
                          color: scheme.onSurface.withValues(alpha: 0.06),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: 92,
                              height: 92,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: scheme.primary.withValues(alpha: 0.08),
                              ),
                              child: const Center(child: AppLogo(size: 54)),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      gradient: LinearGradient(
                                        colors: [
                                          scheme.primary.withValues(alpha: 0),
                                          scheme.primary.withValues(alpha: 0.5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: scheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ShaderMask(
                                  shaderCallback: (b) => LinearGradient(
                                    colors: [scheme.primary, scheme.secondary],
                                  ).createShader(b),
                                  child: const Text(
                                    'Subnex',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: scheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      gradient: LinearGradient(
                                        colors: [
                                          scheme.primary.withValues(alpha: 0.5),
                                          scheme.primary.withValues(alpha: 0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppTranslations.tr('registerTitle'),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppTranslations.tr('registerSubtitle'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: scheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 28),
                            AppTextField(
                              controller: _name,
                              label: AppTranslations.tr('fullName'),
                              prefixIcon: const Icon(Icons.badge_outlined),
                              required: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 14),
                            AppTextField(
                              controller: _email,
                              label: AppTranslations.tr('email'),
                              prefixIcon: const Icon(Icons.mail_outline_rounded),
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (_phone.text.trim().isEmpty &&
                                    (v == null || v.isEmpty)) {
                                  return AppTranslations.tr('requiredField');
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 14),
                            AppTextField(
                              controller: _phone,
                              label: AppTranslations.tr('phone'),
                              prefixIcon: const Icon(Icons.phone_outlined),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 14),
                            AppTextField(
                              controller: _password,
                              label: AppTranslations.tr('password'),
                              prefixIcon: const Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                              obscureText: _obscure,
                              required: true,
                              validator: (v) => v == null || v.length < 6
                                  ? AppTranslations.tr('passwordShort')
                                  : null,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 14),
                            AppTextField(
                              controller: _confirm,
                              label: AppTranslations.tr('confirmPassword'),
                              prefixIcon: const Icon(Icons.lock_outline_rounded),
                              obscureText: _obscure,
                              required: true,
                              validator: (v) => v != _password.text
                                  ? AppTranslations.tr('passwordMismatch')
                                  : null,
                              onSubmitted: (_) => _submit(),
                            ),
                            const SizedBox(height: 26),
                            AppButton(
                              isLoading: loading,
                              fullWidth: true,
                              height: 52,
                              label: AppTranslations.tr('registerButton'),
                              icon: Icons.app_registration_rounded,
                              onPressed: _submit,
                            ),
                            const SizedBox(height: 22),
                            SocialButtons(onTap: _socialLogin),
                            const SizedBox(height: 22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppTranslations.tr('haveAccount'),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: scheme.onSurface.withValues(alpha: 0.6),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                TextButton(
                                  onPressed: loading
                                      ? null
                                      : () => context.go(AppRoutes.login),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    AppTranslations.tr('loginTitle'),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: scheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
