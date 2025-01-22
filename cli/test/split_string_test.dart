import 'package:cli/src/console/console.dart';
import 'package:test/test.dart';

main() {
  group('String splitLinesByLength', () {
    test('String.splitByLines', () {
      var lines = "Short string".splitLinesByLength(50);
      expect(lines.length, 1);
    });

    test('String.splitByLines', () {
      var length = 50;
      var wordCount = 11;
      var word = "1234567890";
      var sentence = List.generate(wordCount, (idx) => word).join(' ');

      var lines = sentence.splitLinesByLength(length);
      var numLinesShouldBe = (sentence.length / length).ceil();
      expect(lines.length, numLinesShouldBe);

      int numWords = 0;
      for (var line in lines) {
        var words = line.split(' ');
        numWords += words.length;
      }

      expect(numWords, wordCount);
    });
  });
}
