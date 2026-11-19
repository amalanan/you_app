import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../core/widgets/status_view.dart';
import '../logic/reflections_controller.dart';
import '../models/reflection_entry.dart';
import '../widgets/reflection_card.dart';

/// My Reflections: the user's situations and scenario answers, newest first.
/// The page owns its controller: created when it opens, disposed when it closes.
class ReflectionsPage extends StatefulWidget {
  const ReflectionsPage({super.key, this.onOpenEntry});

  /// Called when a card is tapped. The details page will plug in here;
  /// until then (null) the cards are not tappable.
  final ValueChanged<ReflectionEntry>? onOpenEntry;

  @override
  State<ReflectionsPage> createState() => _ReflectionsPageState();
}

class _ReflectionsPageState extends State<ReflectionsPage> {
  late final ReflectionsController _controller;
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = ReflectionsController()..load();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Near the bottom: ask for the next page (the controller ignores extra calls).
  void _onScroll() {
    if (!_scroll.hasClients) return;
    final position = _scroll.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      _controller.loadMore();
    }
  }

  Widget _emptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.spa_outlined, size: 56, color: AppColors.secondary),
            const SizedBox(height: AppSizes.md),
            Text(AppStrings.reflectionsEmptyTitle, style: context.text.headlineMedium),
            const SizedBox(height: AppSizes.sm),
            Text(
              AppStrings.reflectionsEmptyBody,
              textAlign: TextAlign.center,
              style: context.text.bodyMedium?.copyWith(color: context.mutedText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _footer() {
    if (_controller.loadMoreFailed) {
      return Column(
        children: [
          Text(
            AppStrings.loadMoreFailed,
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(color: context.mutedText),
          ),
          TextButton(
            onPressed: _controller.retryLoadMore,
            child: Text(AppStrings.retry),
          ),
        ],
      );
    }
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.md),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _body() {
    final c = _controller;

    if (c.entries.isEmpty) {
      final failure = c.failure;
      if (failure != null) {
        return failure is NetworkFailure
            ? StatusView.offline(onRetry: c.load)
            : StatusView.error(message: failure.message, onRetry: c.load);
      }
      if (c.isEmpty) return _emptyView();
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    final showFooter = c.isLoadingMore || c.loadMoreFailed;
    final onOpen = widget.onOpenEntry;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: c.refresh,
      child: ListView.separated(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSizes.screenPadding,
          AppSizes.lg,
          AppSizes.screenPadding,
          AppSizes.lg,
        ),
        itemCount: c.entries.length + (showFooter ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: AppSizes.md),
        itemBuilder: (context, index) {
          if (index == c.entries.length) return _footer();
          final entry = c.entries[index];
          return ReflectionCard(
            key: ValueKey('${entry.kind.name}:${entry.id}'),
            entry: entry,
            onTap: onOpen == null ? null : () => onOpen(entry),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.myReflections)),
      body: SafeArea(
        bottom: false,
        child: ResponsiveCenter(
          maxWidth: 560,
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => _body(),
          ),
        ),
      ),
    );
  }
}