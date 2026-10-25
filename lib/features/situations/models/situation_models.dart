import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';

enum SituationType {
  decision,
  challenge,
  work,
  study,
  relationship,
  personal,
  unexpected,
  other,
}

extension SituationTypeX on SituationType {
  String get label => switch (this) {
        SituationType.decision => AppStrings.typeDecision,
        SituationType.challenge => AppStrings.typeChallenge,
        SituationType.work => AppStrings.typeWork,
        SituationType.study => AppStrings.typeStudy,
        SituationType.relationship => AppStrings.typeRelationship,
        SituationType.personal => AppStrings.typePersonal,
        SituationType.unexpected => AppStrings.typeUnexpected,
        SituationType.other => AppStrings.other,
      };

  IconData get icon => switch (this) {
        SituationType.decision => Icons.alt_route,
        SituationType.challenge => Icons.landscape_outlined,
        SituationType.work => Icons.work_outline,
        SituationType.study => Icons.menu_book_outlined,
        SituationType.relationship => Icons.favorite_border,
        SituationType.personal => Icons.person_outline,
        SituationType.unexpected => Icons.auto_awesome_outlined,
        SituationType.other => Icons.category_outlined,
      };
}

enum Feeling {
  excited,
  nervous,
  confident,
  confused,
  frustrated,
  disappointed,
  hopeful,
  overwhelmed,
  calm,
  other,
}

extension FeelingX on Feeling {
  String get label => switch (this) {
        Feeling.excited => AppStrings.feelExcited,
        Feeling.nervous => AppStrings.feelNervous,
        Feeling.confident => AppStrings.feelConfident,
        Feeling.confused => AppStrings.feelConfused,
        Feeling.frustrated => AppStrings.feelFrustrated,
        Feeling.disappointed => AppStrings.feelDisappointed,
        Feeling.hopeful => AppStrings.feelHopeful,
        Feeling.overwhelmed => AppStrings.feelOverwhelmed,
        Feeling.calm => AppStrings.feelCalm,
        Feeling.other => AppStrings.other,
      };
}
