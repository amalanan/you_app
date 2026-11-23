// // lib/features/reflections/pages/reflection_detail_page.dart
// //
// // NOT COMPILED, NOT TESTED (no Flutter SDK available when this was written).
// // Verified against: reflection_entry.dart, reflection_card.dart,
// // reflections_page.dart, app_router.dart.
// // UNVERIFIED: `Feeling.label` (see _feelingLabel) and the new AppStrings keys.
//
// import 'package:flutter/material.dart' hide Text;
//
// import '../../../core/l10n/text.dart';
//
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_sizes.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../core/helpers/extensions.dart';
// import '../../../core/l10n/app_locale.dart';
// import '../../../core/widgets/responsive_center.dart';
// import '../../situations/models/situation_models.dart';
// import '../models/reflection_entry.dart';
//
// /// Shows one reflection with everything stored for it. Sections with no data
// /// are not shown. Nothing here is generated: it is the user's own words plus
// /// the scenario text that was shown to them.
// class ReflectionDetailPage extends StatelessWidget {
//   const ReflectionDetailPage({super.key, required this.entry});
//
//   final ReflectionEntry entry;
//
//   // UNVERIFIED: assumes Feeling has a `label` like SituationType does.
//   static String _feelingLabel(Feeling feeling) => feeling.label;
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = AppLocale.isArabic ? 'ar' : 'en';
//     final isScenario = entry.isScenario;
//
//     final tag = isScenario
//         ? AppStrings.reflectionScenario
//         : (entry.type?.label ?? AppStrings.other);
//     final icon = isScenario
//         ? Icons.lightbulb_outline
//         : (entry.type?.icon ?? Icons.edit_outlined);
//     final color = isScenario ? AppColors.primary : AppColors.secondary;
//     final muted = context.text.bodySmall?.copyWith(color: context.mutedText);
//
//     final local = entry.createdAt.toLocal();
//     final loc = MaterialLocalizations.of(context);
//     final date =
//         '${loc.formatFullDate(local)} · ${loc.formatTimeOfDay(TimeOfDay.fromDateTime(local))}';
//
//     final sections = <Widget>[];
//
//     void addText(String label, String? value) {
//       if (value == null) return;
//       sections.add(_Section(label: label, child: _BodyText(value)));
//     }
//
//     if (isScenario) {
//       addText(AppStrings.reflectionScenario, entry.prompt?.resolve(lang));
//       addText(AppStrings.whatWouldYouDo, entry.chosenOption?.resolve(lang));
//       addText(AppStrings.whyChoose, entry.reason);
//       addText(AppStrings.whatMattered, entry.matter);
//     } else {
//       addText(AppStrings.whatHappened, entry.whatHappened);
//
//       if (entry.feelings.isNotEmpty) {
//         sections.add(_Section(
//           label: AppStrings.whatDidYouFeel,
//           child: Wrap(
//             spacing: AppSizes.sm,
//             runSpacing: AppSizes.sm,
//             children: [
//               for (final f in entry.feelings)
//                 Chip(label: Text(_feelingLabel(f))),
//             ],
//           ),
//         ));
//       }
//
//       addText(AppStrings.whatDidYouDo, entry.action);
//     }
//
//     if (entry.confidence != null) {
//       sections.add(_Section(
//         label: isScenario
//             ? AppStrings.howConfident
//             : AppStrings.howConfidentResponse,
//         child: _BodyText('${entry.confidence} / 10'),
//       ));
//     }
//
//     if (!isScenario) {
//       addText(AppStrings.whatHappenedAfterward, entry.afterwards);
//       addText(AppStrings.whatDidYouLearn, entry.lesson);
//     }
//     final title = isScenario ? entry.scenarioTitle?.resolve(lang) : null;
//
//     return Scaffold(
//       appBar: AppBar(title: Text(AppStrings.reflectionDetailTitle)),
//       body: SafeArea(
//         bottom: false,
//         child: ResponsiveCenter(
//           maxWidth: 560,
//           child: ListView(
//             padding: const EdgeInsets.fromLTRB(
//               AppSizes.screenPadding,
//               AppSizes.lg,
//               AppSizes.screenPadding,
//               AppSizes.lg,
//             ),
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 22,
//                     height: 22,
//                     decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//                     child: Icon(icon, size: 13, color: AppColors.white),
//                   ),
//                   const SizedBox(width: AppSizes.sm),
//                   Expanded(
//                     child: Text(tag,
//                         maxLines: 1, overflow: TextOverflow.ellipsis, style: muted),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               Text(date, style: muted),
//               if (title != null) ...[
//                 const SizedBox(height: AppSizes.md),
//                 _BodyText(title, style: context.text.headlineMedium),
//               ],
//               const SizedBox(height: AppSizes.lg),
//               for (var i = 0; i < sections.length; i++) ...[
//                 if (i > 0) const SizedBox(height: AppSizes.md),
//                 sections[i],
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _Section extends StatelessWidget {
//   const _Section({required this.label, required this.child});
//
//   final String label;
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     final radius = BorderRadius.circular(AppSizes.radiusMd);
//     return Material(
//       color: context.cardColor,
//       borderRadius: radius,
//       child: Padding(
//         padding: const EdgeInsets.all(AppSizes.md),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: context.text.bodySmall?.copyWith(color: context.mutedText),
//             ),
//             const SizedBox(height: AppSizes.sm),
//             child,
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// Text that follows its own direction: an Arabic reflection written in an
// /// English UI (or the reverse) is laid out correctly.
// class _BodyText extends StatelessWidget {
//   const _BodyText(this.value, {this.style});
//
//   final String value;
//   final TextStyle? style;
//
//   @override
//   Widget build(BuildContext context) {
//     final isArabic = AppLocale.isArabic;
//     final direction =
//     isArabic ? TextDirection.rtl : TextDirection.ltr;
//
//     return Container(
//       width: double.infinity,
//       alignment: isArabic
//           ? Alignment.centerRight
//           : Alignment.centerLeft,
//       child: Directionality(
//         textDirection: direction,
//         child: Text(
//           value,
//           textDirection: direction,
//           textAlign: isArabic ? TextAlign.right : TextAlign.left,
//           style: style ?? context.text.bodyLarge?.copyWith(height: 1.5),
//         ),
//       ),
//     );
//   }
// }
//
// /// Direction from the first strong letter; null (keep the app's) if none.
// TextDirection? _directionOf(String value) {
//   for (final r in value.runes) {
//     if ((r >= 0x0590 && r <= 0x08FF) ||
//         (r >= 0xFB1D && r <= 0xFDFF) ||
//         (r >= 0xFE70 && r <= 0xFEFF)) {
//       return TextDirection.rtl;
//     }
//     if ((r >= 0x41 && r <= 0x5A) ||
//         (r >= 0x61 && r <= 0x7A) ||
//         (r >= 0xC0 && r <= 0x24F)) {
//       return TextDirection.ltr;
//     }
//   }
//   return null;
// }

import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/data_events.dart';
import '../../../core/l10n/app_locale.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../situations/models/situation_models.dart';
import '../data/reflection_repository.dart';
import '../models/reflection_entry.dart';

/// Shows one reflection with everything stored for it.
class ReflectionDetailPage extends StatefulWidget {
  const ReflectionDetailPage({super.key, required this.entry});

  final ReflectionEntry entry;

  @override
  State<ReflectionDetailPage> createState() => _ReflectionDetailPageState();
}

class _ReflectionDetailPageState extends State<ReflectionDetailPage> {
  bool _isDeleting = false;

  ReflectionEntry get entry => widget.entry;

  static String _feelingLabel(Feeling feeling) => feeling.label;

  Future<void> _deleteReflection() async {
    final translate = AppLocale.instance.tr;
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(translate('Delete reflection?')),
            content: Text(
              translate(
                'Are you sure you want to delete this reflection? This action cannot be undone.',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(AppStrings.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(
                  AppStrings.delete,
                  style: TextStyle(
                    color: Theme.of(dialogContext).colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isDeleting = true);

    try {
      await ReflectionRepository.instance.deleteEntry(entry);

      DataEvents.instance.changed();

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;

      setState(() => _isDeleting = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            translate('Could not delete the reflection. Please try again.'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocale.languageCode;
    final isScenario = entry.isScenario;

    final tag =
        isScenario
            ? AppStrings.reflectionScenario
            : (entry.type?.label ?? AppStrings.other);
    final icon =
        isScenario
            ? Icons.lightbulb_outline
            : (entry.type?.icon ?? Icons.edit_outlined);
    final color = isScenario ? AppColors.primary : AppColors.secondary;
    final muted = context.text.bodySmall?.copyWith(color: context.mutedText);

    final local = entry.createdAt.toLocal();
    final loc = MaterialLocalizations.of(context);
    final date =
        '${loc.formatFullDate(local)} · ${loc.formatTimeOfDay(TimeOfDay.fromDateTime(local))}';

    final sections = <Widget>[];

    void addText(String label, String? value) {
      if (value == null) return;
      sections.add(_Section(label: label, child: _BodyText(value)));
    }

    if (isScenario) {
      addText(AppStrings.reflectionScenario, entry.prompt?.resolve(lang));
      addText(AppStrings.whatWouldYouDo, entry.chosenOption?.resolve(lang));
      addText(AppStrings.whyChoose, entry.reason);
      addText(AppStrings.whatMattered, entry.matter);
    } else {
      addText(AppStrings.whatHappened, entry.whatHappened);

      if (entry.feelings.isNotEmpty) {
        sections.add(
          _Section(
            label: AppStrings.whatDidYouFeel,
            child: Wrap(
              spacing: AppSizes.sm,
              runSpacing: AppSizes.sm,
              children: [
                for (final f in entry.feelings)
                  Chip(label: Text(_feelingLabel(f))),
              ],
            ),
          ),
        );
      }

      addText(AppStrings.whatDidYouDo, entry.action);
    }

    if (entry.confidence != null) {
      sections.add(
        _Section(
          label:
              isScenario
                  ? AppStrings.howConfident
                  : AppStrings.howConfidentResponse,
          child: _BodyText('${entry.confidence} / 10'),
        ),
      );
    }

    if (!isScenario) {
      addText(AppStrings.whatHappenedAfterward, entry.afterwards);
      addText(AppStrings.whatDidYouLearn, entry.lesson);
    }

    final title = isScenario ? entry.scenarioTitle?.resolve(lang) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.reflectionDetailTitle),
        actions: [
          IconButton(
            tooltip: AppStrings.delete,
            onPressed: _isDeleting ? null : _deleteReflection,
            icon:
                _isDeleting
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: ResponsiveCenter(
          maxWidth: 560,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.screenPadding,
              AppSizes.lg,
              AppSizes.screenPadding,
              AppSizes.lg,
            ),
            children: [
              Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 13, color: AppColors.white),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: Text(
                      tag,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: muted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(date, style: muted),
              if (title != null) ...[
                const SizedBox(height: AppSizes.md),
                _BodyText(title, style: context.text.headlineMedium),
              ],
              const SizedBox(height: AppSizes.lg),
              for (var i = 0; i < sections.length; i++) ...[
                if (i > 0) const SizedBox(height: AppSizes.md),
                sections[i],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusMd);

    return Material(
      color: context.cardColor,
      borderRadius: radius,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.text.bodySmall?.copyWith(color: context.mutedText),
            ),
            const SizedBox(height: AppSizes.sm),
            child,
          ],
        ),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText(this.value, {this.style});

  final String value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final isArabic = AppLocale.isArabic;
    final direction = isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Container(
      width: double.infinity,
      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: Directionality(
        textDirection: direction,
        child: Text(
          value,
          textDirection: direction,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: style ?? context.text.bodyLarge?.copyWith(height: 1.5),
        ),
      ),
    );
  }
}
