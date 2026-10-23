import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/responsive_center.dart';
import '../models/onboarding_item.dart';
import '../widgets/onboarding_slide.dart';
import '../widgets/page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == onboardingItems.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await LocalStorage.instance.setOnboardingSeen(true);
    if (!mounted) return;
    context.go(AppRoutes.login); // كان AppRoutes.home
  }

  void _next() {
    if (_isLast) {
      _finish();
    } else {
      _controller.nextPage(
        duration: AppDurations.medium,
        curve: Curves.easeOut,
      );
    }
  }

  void _back() {
    _controller.previousPage(
      duration: AppDurations.medium,
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final showBack = _index > 0;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: 800,
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.sm),
                  child: AnimatedOpacity(
                    opacity: showBack ? 1 : 0,
                    duration: AppDurations.short,
                    child: IgnorePointer(
                      ignoring: !showBack,
                      child: IconButton(
                        onPressed: _back,
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingItems.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (_, i) => OnboardingSlide(item: onboardingItems[i]),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.screenPadding,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PageIndicator(
                          count: onboardingItems.length,
                          index: _index,
                        ),
                        const SizedBox(height: AppSizes.md),
                        AppButton(
                          label: _isLast ? AppStrings.startJourney : AppStrings.next,
                          secondary: !_isLast, // purple, then green on the last page
                          onPressed: _next,
                        ),
                        TextButton(
                          onPressed: _finish,
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.onSurface,
                          ),
                          child: const Text(AppStrings.skip),
                        ),
                        const SizedBox(height: AppSizes.sm),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
