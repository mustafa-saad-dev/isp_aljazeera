import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/common/app_text_field.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/auth/auth_state.dart';
import '../../core/helpers/toast_helper.dart';
import '../../core/localization/app_translations.dart';
import '../../core/routes/app_routes.dart';
import '../../models/auth/register_request/register_request.dart';
import '../../widgets/auth/auth.dart';
import '../../widgets/common/app_button.dart';

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

    context.read<AuthController>().register(
      RegisterRequest(
        name: _name.text.trim(),
        password: _password.text,
        email: _email.text.trim().isNotEmpty ? _email.text.trim() : '',
        phone: _phone.text.trim().isNotEmpty ? _phone.text.trim() : '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: BlocConsumer<AuthController, AuthState>(
        listenWhen: (p, c) => c.isError || c.isOffline || c.registered,
        listener: (context, state) {
          if (state.isError || state.isOffline) {
            ToastHelper.showError(context, state.message ?? '');
          }
        },
        builder: (context, state) {
          final loading = state.isLoading;
          return Scaffold(
            backgroundColor: scheme.surface,
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: AuthCardShell(
                    subtitle: AppTranslations.tr('registerSubtitle'),
                    topBar: const AuthTopActions(),
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppTextField(
                              controller: _name,
                              label: AppTranslations.tr('fullName'),
                              prefixIcon: Icons.badge_outlined,
                              required: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 12),
                            AppTextField(
                              controller: _email,
                              label: AppTranslations.tr('email'),
                              prefixIcon: Icons.mail_outline_rounded,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              required: true,
                              validator: (v) {
                                if (_phone.text.trim().isEmpty &&
                                    (v == null || v.isEmpty)) {
                                  return AppTranslations.tr('requiredField');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            AppTextField(
                              controller: _phone,
                              label: AppTranslations.tr('phone'),
                              prefixIcon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              required: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 12),
                            AppTextField(
                              controller: _password,
                              label: AppTranslations.tr('password'),
                              prefixIcon: Icons.lock_outline_rounded,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.4,
                                  ),
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
                              height: 50,
                              label: AppTranslations.tr('registerButton'),
                              onPressed: state.isOffline ? null : _submit,
                              isLoading: loading,
                              fullWidth: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppTranslations.tr('haveAccount'),
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              color: scheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                          const SizedBox(width: 4),
                          AuthLinkText(
                            label: AppTranslations.tr('loginTitle'),
                            isLoading: loading,
                            onPressed: () => context.go(AppRoutes.login),
                          ),
                        ],
                      ),
                    ],
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
