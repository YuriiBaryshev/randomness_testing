import 'dart:typed_data';
import 'dart:math' show Random;

import 'package:randomness_testing/randomness_testing.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    int length = 2500;
    Uint8List allBytesOnes = Uint8List(length);
    Uint8List allBytesZeros = Uint8List(length);

    Uint8List allBytesA = Uint8List(length);
    Uint8List halfOnesHalfZeros = Uint8List(length);
    Uint8List randomOutput = Uint8List(length);

    setUp(() {
      var rand = Random.secure();
      for (int i = 0; i < length; i++) {
        allBytesOnes[i] = 0xff;
        allBytesZeros[i] = 0;
        allBytesA[i] = 0xaa;
        halfOnesHalfZeros[i] = (i < 1250) ? 0xff : 0;
        randomOutput[i] = rand.nextInt(256);
      }
    });


    test('monobit test fails for all the same bits', () {
      expect(RandomnessTester.monobitTest(allBytesZeros), isFalse);
      expect(RandomnessTester.monobitTest(allBytesOnes), isFalse);
    });


    test('monobit test passes for all the same bits', () {
      expect(RandomnessTester.monobitTest(allBytesA), isTrue);
      expect(RandomnessTester.monobitTest(halfOnesHalfZeros), isTrue);
      expect(RandomnessTester.monobitTest(randomOutput), isTrue);
    });


    test('poker test fails for all the same bits', () {
      expect(RandomnessTester.pokerTest(allBytesZeros), isFalse);
      expect(RandomnessTester.pokerTest(allBytesOnes), isFalse);
      expect(RandomnessTester.pokerTest(allBytesA), isFalse);
      expect(RandomnessTester.pokerTest(halfOnesHalfZeros), isFalse);
    });


    test('poker test passes for all the same bits', () {
      expect(RandomnessTester.pokerTest(randomOutput), isTrue);
    });


    test('long run test fails', () {
      expect(RandomnessTester.longRunTest(allBytesZeros), isFalse);
      expect(RandomnessTester.longRunTest(allBytesOnes), isFalse);
      expect(RandomnessTester.longRunTest(halfOnesHalfZeros), isFalse);
    });


    test('long run test passes', () {
      expect(RandomnessTester.longRunTest(allBytesA), isTrue);
      expect(RandomnessTester.longRunTest(randomOutput), isTrue);
    });


    test('runs test fails', () {
      expect(RandomnessTester.runsTest(allBytesZeros), isFalse);
      expect(RandomnessTester.runsTest(allBytesOnes), isFalse);
      expect(RandomnessTester.runsTest(halfOnesHalfZeros), isFalse);
      expect(RandomnessTester.runsTest(allBytesA), isFalse);
    });


    test('runs test passes', () {
      expect(RandomnessTester.runsTest(randomOutput), isTrue);
    });


    test('convert binary string into Uint8List', () {
      Uint8List converted = RandomnessTester.binaryStringToUint8List("111");
      expect(converted, Uint8List.fromList([0xe0]));
      converted = RandomnessTester.binaryStringToUint8List("000000111");
      expect(converted, Uint8List.fromList([3, 0x80]));
      converted = RandomnessTester.binaryStringToUint8List("1111111000000111");
      expect(converted, Uint8List.fromList([0xfe, 0x7]));
      converted = RandomnessTester.binaryStringToUint8List("11111110000001111");
      expect(converted, Uint8List.fromList([0xfe, 0x7, 0x80]));
    });
  });
}
