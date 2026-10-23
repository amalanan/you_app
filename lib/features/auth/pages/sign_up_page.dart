import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/responsive_center.dart';
import '../data/auth_repository.dart';
import '../logic/auth_controller.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_prompt.dart';
import '../widgets/terms_checkbox.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  late final _auth = AuthController(AuthRepository.instance);

  bool _agreed = false;
  bool _showTermsError = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _auth.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final valid = _formKey.currentState!.validate();
    setState(() => _showTermsError = !_agreed);
    if (!valid || !_agreed) return;

    final ok = await _auth.signUp(
      name: _name.text,
      email: _email.text,
      password: _password.text,
    );
    if (!mounted) return;
    if (ok) {
      context.go(AppRoutes.home);
    } else if (_auth.errorMessage != null) {
      context.showSnack(_auth.errorMessage!);
    }
  }

  void _goToLogin() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.login);
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
              builder: (context, _) => CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.screenPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AuthHeader(
                            title: AppStrings.startYourJourney,
                            subtitle: AppStrings.createYourAccount,
                          ),
                          const SizedBox(height: AppSizes.xl),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                AppTextField(
                                  label: AppStrings.name,
                                  hint: AppStrings.nameHint,
                                  controller: _name,
                                  validator: Validators.required,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.name],
                                ),
                                const SizedBox(height: AppSizes.md),
                                AppTextField(
                                  label: AppStrings.email,
                                  hint: AppStrings.emailHint,
                                  controller: _email,
                                  validator: Validators.email,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.email],
                                ),
                                const SizedBox(height: AppSizes.md),
                                AppTextField(
                                  label: AppStrings.password,
                                  hint: AppStrings.passwordHint,
                                  controller: _password,
                                  isPassword: true,
                                  validator: Validators.password,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.newPassword],
                                ),
                                const SizedBox(height: AppSizes.md),
                                AppTextField(
                                  label: AppStrings.confirmPassword,
                                  hint: AppStrings.passwordHint,
                                  controller: _confirm,
                                  isPassword: true,
                                  validator: Validators.confirmPassword(
                                    () => _password.text,
                                  ),
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) => _submit(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSizes.md),
                          TermsCheckbox(
                            value: _agreed,
                            showError: _showTermsError && !_agreed,
                            onChanged: (v) => setState(() {
                              _agreed = v;
                              _showTermsError = false;
                            }),
                          ),
                          const SizedBox(height: AppSizes.lg),
                          AppButton(
                            label: AppStrings.createAccount,
                            secondary: true, // purple, as in the design
                            isLoading: _auth.isLoading,
                            onPressed: _submit,
                          ),
                          const Spacer(),
                          const SizedBox(height: AppSizes.lg),
                          Center(
                            child: AuthPrompt(
                              text: AppStrings.haveAccount,
                              action: AppStrings.logInLink,
                              onTap: _goToLogin,
                            ),
                          ),
                          const SizedBox(height: AppSizes.sm),
                        ],
                      ),
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
