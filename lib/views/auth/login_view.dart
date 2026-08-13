import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:isp_aljazeera/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/auth/auth_state.dart';
import '../../core/helpers/toast_helper.dart';
import '../../core/localization/app_translations.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/social_buttons.dart';

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
  late final SharedPreferences _prefs;

  static const String _kRemember = 'login_remember';
  static const String _kIdentifier = 'login_identifier';

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    final remember = _prefs.getBool(_kRemember) ?? true;
    final savedId = _prefs.getString(_kIdentifier) ?? '';
    setState(() {
      _remember = remember;
      if (remember && savedId.isNotEmpty) _identifier.text = savedId;
    });
  }

  @override
  void dispose() {
    _identifier.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final id = _identifier.text.trim();
    if (_remember) {
      _prefs.setBool(_kRemember, true);
      _prefs.setString(_kIdentifier, id);
    } else {
      _prefs.setBool(_kRemember, false);
      _prefs.remove(_kIdentifier);
    }

    context.read<AuthController>().login(identifier: id, password: _password.text);
  }

  void _forgotPassword() {
    ToastHelper.showWarning(context, AppTranslations.tr('resetPasswordContact'));
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
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
                            AppTranslations.tr('welcomeBack'),
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
                            AppTranslations.tr('loginSubtitle'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: scheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 32),
                          AppTextField(
                            controller: _identifier,
                            label: AppTranslations.tr('identifier'),
                            prefixIcon: const Icon(Icons.mail_outline_rounded),
                            keyboardType: TextInputType.emailAddress,
                            required: true,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),
                          AppTextField(
                            controller: _password,
                            label: AppTranslations.tr('password'),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() => _obscure = !_obscure),
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                            obscureText: _obscure,
                            required: true,
                            onSubmitted: (_) => _submit(),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: loading
                                      ? null
                                      : () => setState(() => _remember = !_remember),
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: Checkbox(
                                          value: _remember,
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
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          AppTranslations.tr('rememberMe'),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: loading ? null : _forgotPassword,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  AppTranslations.tr('forgotPassword'),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: scheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          AppButton(
                            isLoading: loading,
                            fullWidth: true,
                            height: 52,
                            label: AppTranslations.tr('loginButton'),
                            icon: Icons.login_rounded,
                            onPressed: _submit,
                          ),
                          const SizedBox(height: 22),
                          SocialButtons(onTap: _socialLogin),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppTranslations.tr('noAccount'),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: scheme.onSurface.withValues(alpha: 0.6),
                                ),
                              ),
                              const SizedBox(width: 4),
                              TextButton(
                                onPressed: loading
                                    ? null
                                    : () => context.go(AppRoutes.register),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  AppTranslations.tr('registerTitle'),
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
          );
        },
      ),
    );
  }
}
