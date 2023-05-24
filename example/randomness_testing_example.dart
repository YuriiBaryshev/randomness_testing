import 'dart:typed_data';
import 'dart:math' show Random;
import 'package:randomness_testing/randomness_testing.dart';

void main() {
  Uint8List randomOutput = Uint8List(2500);

  var rand = Random.secure();
  for (int i = 0; i < 2500; i++) {
    randomOutput[i] = rand.nextInt(256);
  }
  if (RandomnessTester.monobitTest(randomOutput)) {
   print("Generated sequence passed tests");
  } else {
    print("Generated sequence didn't pass tests");
  }
}
