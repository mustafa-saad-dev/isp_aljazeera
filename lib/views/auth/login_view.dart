import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/common/app_button.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/auth/auth_state.dart';
import '../../core/helpers/toast_helper.dart';
import '../../core/localization/app_translations.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/auth/auth.dart';
import '../../widgets/common/app_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _remember = true;

  @override
  void dispose() {
    _identifier.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final id = _identifier.text.trim();

    context.read<AuthController>().login(
      identifier: id,
      password: _password.text,
      remember: _remember,
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
        listenWhen: (p, c) => c.user != null || c.isError || c.isOffline,
        listener: (context, state) {
          if (state.user != null) {
            context.go(AppRoutes.home);
          } else if (state.isError || state.isOffline) {
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
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: AuthCardShell(
                    subtitle: AppTranslations.tr('loginSubtitle'),
                    topBar: const AuthTopActions(),
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppTextField(
                              controller: _identifier,
                              label: AppTranslations.tr('identifier'),
                              prefixIcon: Icons.mail_outline_rounded,
                              keyboardType: TextInputType.emailAddress,
                              required: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 25),
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
                              onSubmitted: (_) => _submit(),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                InkWell(
                                  onTap: loading
                                      ? null
                                      : () => setState(
                                          () => _remember = !_remember,
                                        ),
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Checkbox(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          value: _remember,
                                          activeColor: scheme.primary,
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          onChanged: loading
                                              ? null
                                              : (v) => setState(
                                                  () => _remember = v ?? false,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        AppTranslations.tr('rememberMe'),
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontSize: 13,
                                          color: scheme.onSurface.withValues(
                                            alpha: 0.6,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                AuthLinkText(
                                  label: AppTranslations.tr('forgotPassword'),
                                  isLoading: loading,
                                  onPressed: () =>
                                      context.push(AppRoutes.forgetPassword),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            AppButton(
                              height: 45,
                              label: AppTranslations.tr('loginButton'),
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
                            AppTranslations.tr('noAccount'),
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              color: scheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                          const SizedBox(width: 4),
                          AuthLinkText(
                            label: AppTranslations.tr('registerTitle'),
                            isLoading: loading,
                            onPressed: () => context.push(AppRoutes.register),
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
