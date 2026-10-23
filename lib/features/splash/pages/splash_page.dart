import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/storage/local_storage.dart';
import '../../auth/data/auth_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppDurations.splash);

    const intro = Interval(0, 0.35, curve: Curves.easeOut);
    _fade = CurvedAnimation(parent: _controller, curve: intro);
    _scale = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: intro),
    );

    _controller.forward().whenComplete(_goNext);
  }

  void _goNext() {
    if (!mounted) return;
    final String route;
    if (!LocalStorage.instance.onboardingSeen) {
      route = AppRoutes.onboarding;
    } else if (AuthRepository.instance.isLoggedIn) {
      route = AppRoutes.home;
    } else {
      route = AppRoutes.login;
    }
    context.go(route);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  // scaleDown keeps everything visible in landscape / short screens
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: FadeTransition(
                      opacity: _fade,
                      child: ScaleTransition(
                        scale: _scale,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(AppAssets.logo, width: context.rs(120)),
                            const SizedBox(height: AppSizes.md),
                            Text(
                              AppStrings.appName,
                              style: context.text.displayLarge
                                  ?.copyWith(fontSize: context.rs(56)),
                            ),
                            const SizedBox(height: AppSizes.sm),
                            Text(
                              AppStrings.tagline,
                              style: context.text.bodyLarge?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: context.rs(AppSizes.xxl)),
                child: _ProgressBar(animation: _controller, isDark: isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.animation, required this.isDark});

  final Animation<double> animation;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.rs(140),
      height: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (_, __) => FractionallySizedBox(
                alignment: AlignmentDirectional.centerStart,
                widthFactor: animation.value,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.logoPurple, AppColors.primary],
                    ),
                  ),
                  child: SizedBox.expand(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
