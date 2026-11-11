import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/helpers/validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/responsive_center.dart';
import '../data/auth_repository.dart';
import '../logic/auth_controller.dart';

/// "Reset password": opened by the link in the "forgot password" email.
/// New password + confirmation, then Save.
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  late final _auth = AuthController(AuthRepository.instance);

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    _auth.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final ok = await _auth.updatePassword(_password.text);
    if (!mounted) return;
    if (ok) {
      context.showSnack(AppStrings.passwordUpdated);
      context.go(AppRoutes.home); // she is already signed in by the reset link
    } else if (_auth.errorMessage != null) {
      context.showSnack(_auth.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: ResponsiveCenter(
            child: ListenableBuilder(
              listenable: _auth,
              builder: (context, _) => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.screenPadding,
                  vertical: AppSizes.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.resetPasswordTitle,
                      style: context.text.headlineLarge
                          ?.copyWith(fontSize: context.rs(28)),
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      AppStrings.resetPasswordSubtitle,
                      style: context.text.bodyMedium
                          ?.copyWith(color: context.mutedText),
                    ),
                    const SizedBox(height: AppSizes.xl),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextField(
                            label: AppStrings.newPassword,
                            hint: AppStrings.passwordHint,
                            controller: _password,
                            isPassword: true,
                            validator: Validators.password,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.newPassword],
                          ),
                          const SizedBox(height: AppSizes.md),
                          AppTextField(
                            label: AppStrings.confirmNewPassword,
                            hint: AppStrings.passwordHint,
                            controller: _confirm,
                            isPassword: true,
                            validator: Validators.confirmPassword(() => _password.text),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _save(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.xl),
                    AppButton(
                      label: AppStrings.savePassword,
                      isLoading: _auth.isLoading,
                      onPressed: _save,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
