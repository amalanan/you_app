import 'dart:async';

import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/responsive_center.dart';
import '../data/auth_repository.dart';
import '../logic/auth_controller.dart';

/// "Check your email": we emailed her a link. When she taps it, the app opens and
/// she goes straight to Home (see email_link_listener.dart). Nothing to type here.
class CheckEmailPage extends StatefulWidget {
  const CheckEmailPage({super.key, required this.email});

  final String email;

  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  static const _cooldown = 60; // seconds before the email can be sent again

  late final _auth = AuthController(AuthRepository.instance);
  Timer? _timer;
  int _seconds = _cooldown;

  @override
  void initState() {
    super.initState();
    _startCooldown(); // an email was just sent
  }

  @override
  void dispose() {
    _timer?.cancel();
    _auth.dispose();
    super.dispose();
  }

  void _startCooldown() {
    _timer?.cancel();
    _seconds = _cooldown;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => _seconds--);
      if (_seconds <= 0) t.cancel();
    });
  }

  Future<void> _resend() async {
    if (_seconds > 0) return;
    final ok = await _auth.resendConfirmationEmail(widget.email);
    if (!mounted) return;
    if (ok) {
      context.showSnack(AppStrings.emailResent);
      _startCooldown();
    } else if (_auth.errorMessage != null) {
      context.showSnack(_auth.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          child: ListenableBuilder(
            listenable: _auth,
            builder: (context, _) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.mark_email_unread_outlined,
                    size: 72,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: AppSizes.lg),
                  Text(
                    AppStrings.checkEmailTitle,
                    textAlign: TextAlign.center,
                    style: context.text.headlineLarge,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    AppStrings.checkEmailSubtitle(widget.email),
                    textAlign: TextAlign.center,
                    style: context.text.bodyMedium
                        ?.copyWith(color: context.mutedText, height: 1.6),
                  ),
                  const SizedBox(height: AppSizes.xl),
                  AppButton(
                    label: _seconds > 0
                        ? AppStrings.resendEmailIn(_seconds)
                        : AppStrings.resendEmail,
                    secondary: true,
                    isLoading: _auth.isLoading,
                    onPressed: _seconds > 0 ? null : _resend,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.login),
                    child: const Text(AppStrings.backToLogin),
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
