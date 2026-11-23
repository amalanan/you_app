import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/l10n/app_locale.dart';
import '../../situations/models/situation_models.dart';
import '../models/reflection_entry.dart';

/// One reflection (a situation or a scenario answer) in the My Reflections list.
/// Shows the kind, the date and a short preview of the user's own words.
class ReflectionCard extends StatelessWidget {
  const ReflectionCard({super.key, required this.entry, this.onTap});

  final ReflectionEntry entry;
  final VoidCallback? onTap;

  static String? _clean(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  /// Today / Yesterday / a localized date, by LOCAL calendar day.
  /// The day is read from the local time first. The two days are then compared
  /// as UTC midnights, so a daylight-saving change cannot shift the result.
  static String _dateLabel(BuildContext context, DateTime date) {
    final local = date.toLocal();
    final now = DateTime.now();
    final today = DateTime.utc(now.year, now.month, now.day);
    final day = DateTime.utc(local.year, local.month, local.day);
    final days = today.difference(day).inDays;
    if (days == 0) return AppStrings.today;
    if (days == 1) return AppStrings.yesterday;
    return MaterialLocalizations.of(context).formatMediumDate(local);
  }

  /// Title and optional second line. Missing data never leaves the card empty:
  /// a scenario falls back title -> prompt -> chosen answer -> its kind label.
  (String, String?) _texts(String lang, String fallback) {
    if (entry.isSituation) {
      return (_clean(entry.whatHappened) ?? fallback, null);
    }
    final title = _clean(entry.scenarioTitle?.resolve(lang));
    final prompt = _clean(entry.prompt?.resolve(lang));
    final option = _clean(entry.chosenOption?.resolve(lang));
    final heading = title ?? prompt ?? option ?? fallback;
    final reason = _clean(entry.reason);
    // The user's own words come first; otherwise show the answer they chose.
    final body = reason ?? (heading == option ? null : option);
    return (heading, body);
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
    final (title, body) = _texts(lang, tag);

    final radius = BorderRadius.circular(AppSizes.radiusMd);
    final muted = context.text.bodySmall?.copyWith(color: context.mutedText);

    return Material(
      color: context.cardColor,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(width: AppSizes.sm),
                  Text(_dateLabel(context, entry.createdAt), style: muted),
                ],
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.text.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (body != null) ...[
                const SizedBox(height: 4),
                Text(
                  body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.mutedText,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
