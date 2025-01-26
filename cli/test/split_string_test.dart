import 'package:cli/src/console/console.dart';
import 'package:test/test.dart';

void main() {
  group('String splitLinesByLength', () {
    test('String.splitByLines', () {
      final List<String> lines = 'Short string'
          .splitLinesByLength(50);
      expect(lines.length, 1);
    });

    test('String.splitByLines', () {
      const int length = 50;
      const int wordCount = 11;
      const String word = '1234567890';
      final String sentence = List<String>.generate(
        wordCount,
        (int idx) => word,
      ).join(' ');

      final List<String> lines = sentence
          .splitLinesByLength(length);
      final int numLinesShouldBe =
          (sentence.length / length).ceil();
      expect(lines.length, numLinesShouldBe);

      int numWords = 0;
      for (final String line in lines) {
        final List<String> words = line.split(' ');
        numWords += words.length;
      }

      expect(numWords, wordCount);
    });
  });
}
