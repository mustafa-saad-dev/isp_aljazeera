import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/forget_password/forgot_password_controller.dart';
import '../../core/localization/app_translations.dart';
import '../../widgets/auth/auth.dart';
import '../../widgets/common/app_button.dart';

class OtpVerifyView extends StatefulWidget {
  const OtpVerifyView({super.key});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
  static const _length = 6;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_length, (_) => TextEditingController());
    _focusNodes = List.generate(_length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  bool get _isComplete => _otp.length == _length;

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      _controllers[index].text = value[value.length - 1];
      _controllers[index].selection = TextSelection.fromPosition(
        const TextPosition(offset: 1),
      );
    }
    if (value.isNotEmpty && index < _length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (_isComplete) {
      _submit();
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _submit() {
    if (!_isComplete) return;
    context.read<ForgotPasswordController>().verifyOtp(_otp);
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
              constraints: const BoxConstraints(maxWidth: 400),
              child: AuthCardShell(
                subtitle: AppTranslations.tr('otpSubtitle'),
                topBar: const AuthTopActions(),
                children: [
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_length, (i) {
                              return Padding(
                                padding: EdgeInsets.only(left: i > 0 ? 10 : 0),
                                child: SizedBox(
                                  width: 48,
                                  height: 54,
                                  child: KeyboardListener(
                                    focusNode: FocusNode(),
                                    onKeyEvent: (event) =>
                                        _onKeyEvent(i, event),
                                    child: TextField(
                                      controller: _controllers[i],
                                      focusNode: _focusNodes[i],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: InputDecoration(
                                        counterText: '',
                                        filled: true,
                                        fillColor: scheme.onSurface
                                            .withValues(alpha: 0.04),
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: scheme.onSurface
                                                .withValues(alpha: 0.08),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: scheme.onSurface
                                                .withValues(alpha: 0.08),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: scheme.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: scheme.error,
                                          ),
                                        ),
                                      ),
                                      onChanged: (v) => _onChanged(i, v),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 40),
                        AppButton(
                          height: 45,
                          label: AppTranslations.tr('verifyCode'),
                          onPressed: _isComplete ? _submit : null,
                          isLoading: loading,
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AuthLinkText(
                    label: AppTranslations.tr('resendCode'),
                    isLoading: loading,
                    onPressed: () {
                      final id = context
                          .read<ForgotPasswordController>()
                          .state
                          .identifier;
                      context.read<ForgotPasswordController>().sendOtp(id);
                    },
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
