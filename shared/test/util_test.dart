import 'package:shared/src/util.dart';
import 'package:test/test.dart';

main() {
  test('String.splitByLines', () {
    var lines = "Short string".splitLinesByLength(50);
    expect(lines.length, 1);
  });

  test('String.splitByLines', () {
    var length = 50;
    var wordCount = 11;
    var word = "1234567890";
    var sentence = '';
    for (var i = 0; i < wordCount; i++) {
      sentence += word;
      if (i + 1 != wordCount) {
        sentence += ' ';
      }
    }

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
}
