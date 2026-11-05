import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/responsive.dart';
import '../../../core/models/growth_type.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_segmented.dart';
import '../../../core/widgets/status_view.dart';
import '../../../core/widgets/sub_page.dart';
import '../data/growth_repository.dart';
import '../models/growth_detail.dart';
import '../widgets/growth_line_chart.dart';

/// One skill: range tabs, current / previous score, chart and notes.
class GrowthDetailPage extends StatefulWidget {
  const GrowthDetailPage({super.key, required this.type});

  final GrowthType type;

  @override
  State<GrowthDetailPage> createState() => _GrowthDetailPageState();
}

class _GrowthDetailPageState extends State<GrowthDetailPage> {
  GrowthRange _range = GrowthRange.week;
  GrowthDetail? _detail;
  Failure? _failure;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final range = _range;
    setState(() {
      _loading = true;
      _failure = null;
    });
    try {
      final detail = await GrowthRepository.instance.fetchDetail(widget.type, range);
      if (!mounted || range != _range) return; // the user already changed the range
      setState(() {
        _detail = detail;
        _loading = false;
      });
    } catch (e) {
      if (!mounted || range != _range) return;
      setState(() {
        _failure = ErrorHandler.handle(e);
        _loading = false;
      });
    }
  }

  void _changeRange(int index) {
    setState(() => _range = GrowthRange.values[index]);
    _load();
  }

  Widget _body() {
    final detail = _detail;
    if (_failure != null && detail == null) {
      final failure = _failure!;
      return SizedBox(
        height: 320,
        child: failure is NetworkFailure
            ? StatusView.offline(onRetry: _load)
            : StatusView.error(message: failure.message, onRetry: _load),
      );
    }
    if (detail == null) {
      return const SizedBox(
        height: 320,
        child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }
    // while another range loads, the previous numbers stay (a little faded)
    return Opacity(opacity: _loading ? 0.5 : 1, child: _content(detail));
  }

  Widget _content(GrowthDetail detail) {
    final change = detail.change;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Text(
                '${detail.current}',
                style: context.text.displayLarge?.copyWith(
                  fontSize: context.rs(44),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
              Text(
                AppStrings.currentScore,
                style: context.text.bodySmall?.copyWith(color: context.mutedText),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Stat(value: '${detail.previous}', label: AppStrings.previousScore),
            _Stat(
              value: '${change >= 0 ? '+' : ''}$change',
              label: AppStrings.change,
              end: true,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.lg),
        GrowthLineChart(points: detail.points),
        const SizedBox(height: AppSizes.xl),
        SizedBox(
          width: double.infinity,
          child: AppCard(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.whatDoesItMean,
                  style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSizes.sm),
                Text(
                  detail.meaning,
                  style: context.text.bodyMedium
                      ?.copyWith(color: context.mutedText, height: 1.6),
                ),
              ],
            ),
          ),
        ),
        // her own recent words for this skill: only shown when there are some
        if (detail.experiences.isNotEmpty) ...[
          const SizedBox(height: AppSizes.lg),
          Text(
            AppStrings.fromRecentExperiences,
            style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSizes.md),
          for (final text in detail.experiences) ...[
            SizedBox(
              width: double.infinity,
              child: AppCard(child: Text(text, style: context.text.bodySmall)),
            ),
            const SizedBox(height: AppSizes.sm),
          ],
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubPage(
      title: widget.type.label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSegmented(
            labels: [for (final r in GrowthRange.values) r.label],
            selectedIndex: _range.index,
            onChanged: _changeRange,
          ),
          const SizedBox(height: AppSizes.lg),
          _body(),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, this.end = false});

  final String value;
  final String label;
  final bool end;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(value, style: context.text.headlineLarge),
        Text(
          label,
          style: context.text.bodySmall?.copyWith(color: context.mutedText),
        ),
      ],
    );
  }
}
