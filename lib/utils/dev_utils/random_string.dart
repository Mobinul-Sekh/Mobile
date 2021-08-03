// Dart imports:
import 'dart:math';

String randomSentence({
  int sentenceLength = 30,
  int avgWordLength = 5,
}) {
  final Random rng = Random();
  final int stringLength = rng.nextInt(sentenceLength) + 1;
  final List<int> charCodes = [];
  for (int i = 0; i < stringLength; i++) {
    final int randChar;
    if (i == 0) {
      randChar = rng.nextInt(26) + 65;
    } else {
      randChar = rng.nextInt(26) + 97;
    }
    charCodes.add(randChar);
    if (rng.nextInt(100) % avgWordLength == 0) {
      charCodes.add(32);
    }
  }
  charCodes.add(46);
  return String.fromCharCodes(charCodes);
}
