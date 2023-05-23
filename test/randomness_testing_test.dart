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
  });
}
