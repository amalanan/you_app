
import 'package:flutter/services.dart';
import 'package:spell_check_on_client/spell_check_on_client.dart';

class SituationTextChecker {
  late final SpellCheck _english;
  late final SpellCheck _arabic;

  Future<void> initialize() async {
    final contents = await Future.wait([
      rootBundle.loadString('assets/dictionaries/en_words.txt'),
      rootBundle.loadString('assets/dictionaries/ar_words.txt'),
    ]);

    _english = SpellCheck.fromWordsContent(
      contents[0],
      letters: LanguageLetters.englishLetters(),
    );

    _arabic = SpellCheck.fromWordsContent(
      contents[1],
      letters: LanguageLetters.arabicLetters(),
    );
  }

  bool isMeaningful(String text) {
    final tokens = WordTokenizer.tokenize(text)
        .where(
          (word) => RegExp(r'[a-zA-Z\u0600-\u06FF]').hasMatch(word),
    )
        .toList();

    if (tokens.isEmpty) return false;

    var knownWords = 0;

    for (final token in tokens) {
      final word = token.toLowerCase();

      if (_english.isCorrect(word) || _arabic.isCorrect(word)) {
        knownWords++;
      }
    }

    // At least half of the words should be recognized.
    return knownWords >= (tokens.length / 2).ceil();
  }
}
