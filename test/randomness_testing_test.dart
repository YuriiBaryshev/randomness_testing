import 'dart:typed_data';

import 'package:randomness_testing/randomness_testing.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    Uint8List all3BytesOnes = Uint8List.fromList([0xff, 0xff, 0xff]);
    Uint8List all3BytesZeros = Uint8List.fromList([0x0, 0x0, 0x0]);

    Uint8List all3BytesA = Uint8List.fromList([0xaa, 0xaa, 0xaa]);
    Uint8List set4Bytes = Uint8List.fromList([0x00, 0xff, 0x00, 0xff]);


    test('fails for all the same bits', () {
      expect(RandomnessTester.monobitTest(all3BytesZeros), isFalse);
      expect(RandomnessTester.monobitTest(all3BytesOnes), isFalse);
    });


    test('fails for all the same bits', () {
      expect(RandomnessTester.monobitTest(all3BytesA), isTrue);
      expect(RandomnessTester.monobitTest(set4Bytes), isTrue);
    });


    test('monobit test for binary string from NIST STS', () {
      expect(RandomnessTester.monobitTestForBinaryString("1011010101"), isTrue);
      expect(RandomnessTester.monobitTestForBinaryString("0100101010"), isTrue);
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
