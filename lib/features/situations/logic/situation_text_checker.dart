//
// import 'package:flutter/services.dart';
// import 'package:spell_check_on_client/spell_check_on_client.dart';
//
// class SituationTextChecker {
//   late final SpellCheck _english;
//   late final SpellCheck _arabic;
//
//   Future<void> initialize() async {
//     final contents = await Future.wait([
//       rootBundle.loadString('assets/dictionaries/en_words.txt'),
//       rootBundle.loadString('assets/dictionaries/ar_words.txt'),
//     ]);
//
//     _english = SpellCheck.fromWordsContent(
//       contents[0],
//       letters: LanguageLetters.englishLetters(),
//     );
//
//     _arabic = SpellCheck.fromWordsContent(
//       contents[1],
//       letters: LanguageLetters.arabicLetters(),
//     );
//   }
//
//   bool isMeaningful(String text) {
//     final tokens = WordTokenizer.tokenize(text)
//         .where(
//           (word) => RegExp(r'[a-zA-Z\u0600-\u06FF]').hasMatch(word),
//     )
//         .toList();
//
//     if (tokens.isEmpty) return false;
//
//     var knownWords = 0;
//
//     for (final token in tokens) {
//       final word = token.toLowerCase();
//
//       if (_english.isCorrect(word) || _arabic.isCorrect(word)) {
//         knownWords++;
//       }
//     }
//
//     // At least half of the words should be recognized.
//     return knownWords >= (tokens.length / 2).ceil();
//   }
// }
class SituationTextChecker {
  Future<void> initialize() async {}

  static const _letterPattern = r'[a-zA-Z\u0621-\u064A\u066E-\u06D3]';

  static const _keyboardRows = [
    'qwertyuiop',
    'asdfghjkl',
    'zxcvbnm',
    'ضصثقفغعهخحجد',
    'شسيبلاتنمكط',
    'ئءؤرلاىةوزظ',
  ];

  bool isMeaningful(String text) {
    final value = text.toLowerCase().trim();

    if (value.isEmpty) return false;

    final letters = value
        .replaceAll(RegExp('[^a-zA-Z\\u0621-\\u064A\\u066E-\\u06D3]'), '');

    if (letters.isEmpty) return false;

    if (_hasRepeatedCharacters(letters)) return false;

    if (_hasKeyboardMash(letters)) return false;

    if (_hasRepeatedPattern(letters)) return false;

    if (_hasRepeatedWords(value)) return false;

    return true;
  }

  bool _hasRepeatedCharacters(String text) {
    return RegExp(r'^(.)\1{4,}$').hasMatch(text);
  }

  bool _hasKeyboardMash(String text) {
    for (final row in _keyboardRows) {
      var consecutive = 0;

      for (final char in text.split('')) {
        if (row.contains(char)) {
          consecutive++;

          if (consecutive >= 8) return true;
        } else {
          consecutive = 0;
        }
      }
    }

    return false;
  }

  bool _hasRepeatedPattern(String text) {
    if (text.length < 8) return false;

    for (var size = 1; size <= 3; size++) {
      if (text.length % size != 0) continue;

      final pattern = text.substring(0, size);
      final repeated = pattern * (text.length ~/ size);

      if (text == repeated) return true;
    }

    return false;
  }

  bool _hasRepeatedWords(String text) {
    final words = text
        .split(RegExp(r'\s+'))
        .where((word) => RegExp(_letterPattern).hasMatch(word))
        .toList();

    if (words.length < 4) return false;

    final normalized = words.map((word) {
      return word.replaceAll(RegExp(r'[^\w\u0621-\u064A\u066E-\u06D3]'), '');
    }).toList();

    return normalized.toSet().length == 1;
  }
}