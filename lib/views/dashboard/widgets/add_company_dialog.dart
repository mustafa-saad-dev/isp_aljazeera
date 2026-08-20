import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/dashboard/dashboard_state.dart';
import '../../../core/status/request_status.dart';

import '../../../controllers/dashboard/dashboard_controller.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/toast/app_toast.dart';
import '../../../widgets/common/app_button.dart';
import '../../../widgets/common/app_text_field.dart';

class AddCompanyDialog extends StatefulWidget {
  const AddCompanyDialog({super.key, this.onAdded});

  static Future<void> show(BuildContext context, {VoidCallback? onAdded}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: context.read<DashboardController>(),
        child: AddCompanyDialog(onAdded: onAdded),
      ),
    );
  }

  final VoidCallback? onAdded;

  @override
  State<AddCompanyDialog> createState() => _AddCompanyDialogState();
}

class _AddCompanyDialogState extends State<AddCompanyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _urlCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _urlCtrl.dispose();
    _nameCtrl.dispose();
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<DashboardController>().addCompany(
      link: _urlCtrl.text.trim(),
      name: _nameCtrl.text.trim(),
      userName: _userCtrl.text.trim(),
      password: _passCtrl.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocConsumer<DashboardController, DashboardState>(
      listenWhen: (p, c) => p.isSubmitting && !c.isSubmitting,
      listener: (context, state) {
        if (state.status == RequestStatus.empty && state.message != null) {
          AppToast.error(context, state.message!);
          return;
        }
        if (state.hasCompanies && state.status == RequestStatus.success) {
          widget.onAdded?.call();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final loading = state.isSubmitting;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: scheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.dns_outlined,
                            color: scheme.primary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppTranslations.tr('addProvider'),
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                AppTranslations.tr('addProviderSubtitle'),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: scheme.onSurface.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AppTextField(
                      controller: _urlCtrl,
                      label: AppTranslations.tr('providerUrl'),
                      hint: 'https://api.example.com',
                      prefixIcon: Icons.link_rounded,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      required: true,
                      enabled: !loading,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return AppTranslations.tr('requiredField');
                        }
                        final trimmed = v.trim();
                        if (!trimmed.startsWith('http://') &&
                            !trimmed.startsWith('https://')) {
                          return AppTranslations.tr('invalidUrl');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _nameCtrl,
                      label: AppTranslations.tr('providerName'),
                      prefixIcon: Icons.business_outlined,
                      textInputAction: TextInputAction.next,
                      enabled: !loading,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _userCtrl,
                      label: AppTranslations.tr('identifier'),
                      prefixIcon: Icons.person_outline_rounded,
                      textInputAction: TextInputAction.next,
                      required: true,
                      enabled: !loading,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _passCtrl,
                      label: AppTranslations.tr('password'),
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: _obscure,
                      required: true,
                      enabled: !loading,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      suffixIcon: IconButton(
                        onPressed: loading
                            ? null
                            : () => setState(() => _obscure = !_obscure),
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: scheme.onSurface.withValues(alpha: 0.4),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    AppButton(
                      height: 45,
                      label: AppTranslations.tr('validateAndAdd'),
                      onPressed: loading ? null : _submit,
                      isLoading: loading,
                      fullWidth: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
