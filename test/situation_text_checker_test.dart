import 'package:flutter_test/flutter_test.dart';
import 'package:you_app/features/situations/logic/situation_text_checker.dart';

void main() {
  late SituationTextChecker checker;

  setUpAll(() async {
    checker = SituationTextChecker();
    await checker.initialize();
  });

  group('SituationTextChecker', () {
    group('Accepts natural writing', () {
      final validTexts = [
        'بدي أغير طريقة تفكيري',
        'شو رأيك بالموضوع؟',
        'أنا مش عارفة شو أعمل',
        'لسا بفكر بالموضوع',
        'I feel confused today',
        "I don't know شو بدي أعمل",
        'ههههه الموقف كان غريب',
        'بفكر بالموضووع ومش عارفة',
        'مش عارف',
        'نعم',
        'السلام عليكم',
        'كيف حالك اليوم؟',
        'بدي أروح عالبيت',
        'الموضوع مش سهل',
        'استراتيجية جديدة',
        'المستقبل لسه مش واضح',
        'ههههه مش قادرة أصدق',
        'I\'m trying to understand what happened',
        'This الموضوع is confusing',
        'سلسلة أفكار مختلفة',
      ];

      for (final text in validTexts) {
        test('accepts: $text', () {
          expect(checker.isMeaningful(text), isTrue);
        });
      }
    });

    group('Rejects obvious nonsense', () {
      final invalidTexts = [
        '',
        '     ',
        '!!! ؟؟؟ ...',
        'asdfghjkl',
        'qwertyui',
        'اشسينيببل',
        'سسسسسسسسسس',
        'هههههههههههههههه',
        'abcabcabcabc',
        'test test test test test test',
        'a s d f g h j k l',
        'ا ش س ي ن ي ب ب ل',
        'بلبلبلبلبلبل',
        'هههههههههههه',
      ];

      for (final text in invalidTexts) {
        test('rejects: $text', () {
          expect(checker.isMeaningful(text), isFalse);
        });
      }
    });
  });
}