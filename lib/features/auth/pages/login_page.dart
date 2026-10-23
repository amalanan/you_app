import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
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
import '../widgets/google_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  late final _auth = AuthController(AuthRepository.instance);

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _auth.dispose();
    super.dispose();
  }

  void _onResult(bool ok) {
    if (!mounted) return;
    if (ok) {
      context.go(AppRoutes.home);
    } else if (_auth.errorMessage != null) {
      context.showSnack(_auth.errorMessage!);
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _onResult(await _auth.signIn(email: _email.text, password: _password.text));
  }

  Future<void> _google() async {
    FocusScope.of(context).unfocus();
    _onResult(await _auth.signInWithGoogle());
  }

  Future<void> _forgotPassword() async {
    FocusScope.of(context).unfocus();
    if (Validators.email(_email.text) != null) {
      context.showSnack(AppStrings.enterEmailFirst);
      return;
    }
    final ok = await _auth.sendPasswordReset(_email.text);
    if (!mounted) return;
    context.showSnack(
      ok ? AppStrings.resetLinkSent : (_auth.errorMessage ?? AppStrings.unknownError),
    );
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
                            title: AppStrings.welcomeBack,
                            subtitle: AppStrings.continueJourney,
                          ),
                          const SizedBox(height: AppSizes.xl),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
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
                                  validator: Validators.required,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [AutofillHints.password],
                                  onSubmitted: (_) => _submit(),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              onPressed: _auth.isLoading ? null : _forgotPassword,
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.secondary,
                                textStyle: context.text.bodySmall?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              child: const Text(AppStrings.forgotPassword),
                            ),
                          ),
                          const SizedBox(height: AppSizes.sm),
                          AppButton(
                            label: AppStrings.logIn,
                            isLoading: _auth.isLoading,
                            onPressed: _submit,
                          ),
                          const SizedBox(height: AppSizes.lg),
                          Center(
                            child: Text(
                              AppStrings.or,
                              style: context.text.bodySmall
                                  ?.copyWith(color: context.mutedText),
                            ),
                          ),
                          const SizedBox(height: AppSizes.lg),
                          GoogleButton(
                            isLoading: _auth.isLoading,
                            onPressed: _google,
                          ),
                          const Spacer(),
                          const SizedBox(height: AppSizes.lg),
                          Center(
                            child: AuthPrompt(
                              text: AppStrings.noAccount,
                              action: AppStrings.createOne,
                              onTap: () => context.push(AppRoutes.signUp),
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
