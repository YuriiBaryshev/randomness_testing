import 'dart:typed_data';

/// Implements FIPS 140 statistical tests
class RandomnessTester {
  ///Implements monobit test for the byte array/list
  static bool monobitTest(Uint8List data, [int? bitLength]) {
    bitLength ??= data.length << 3; //i.e. data is fully staffed

    if(bitLength > (data.length << 3)) {
      throw ArgumentError("RandomnessTester: data is shorter provided bitLength");
    }

    if(bitLength < (data.length << 3) - 7) {
      throw ArgumentError("RandomnessTester: data is longer provided bitLength");
    }

    int s = 0;
    for(int i = 0; i < data.length - 1; i++) {
      for (int mask = 0x80; mask != 0; mask = mask >> 1) {
        if ((mask & data[i]) == mask) {
          s++;
        }
      }
    }

    int j = bitLength & 7;
    if (j == 0) {
      j = 8;
    }

    for (int mask = 0x80; mask != 0 && j != 0; mask = mask >> 1, j--) {
      if ((mask & data[data.length - 1]) == mask) {
        s++;
      }
    }

    return ((s > 9654) && (s < 10346)); //changed according to 2.1 of the task assignment
  }


  ///Implements Poker test of FIPS 140
  static bool pokerTest(Uint8List data) {
    List<int> g = List<int>.filled(16, 0, growable: false);
    for(int i = 0; i < data.length; i++) {
      g[data[i] & 0xf]++;
      g[data[i] >> 4]++;
    }
    double x = 16/5000;
    int sum = 0;
    for(int i = 0; i < 16; i++) {
      sum += g[i] * g[i];
    }
    x *= sum;
    x -= 5000;
    return (x > 1.03) && (x < 57.4); //changed according to 2.3 of the task assignment
  }


  ///Implements monobit test for the bit string
  static monobitTestForBinaryString(String binaryData) {
    Uint8List data = RandomnessTester.binaryStringToUint8List(binaryData);
    return RandomnessTester.monobitTest(data, binaryData.length);
  }


  ///Converts binaryStringToUint8List
  static Uint8List binaryStringToUint8List(String binaryData) {
    RegExp alphabet = RegExp("^[01]+");
    if (!alphabet.hasMatch(binaryData)) {
      throw ArgumentError(
          "RandomnessTester: provided input must be a string of bits");
    }
    bool isNotMultiple8 = (binaryData.length & 7) != 0;
    int byteLength = binaryData.length >> 3;
    if (isNotMultiple8) {
      byteLength++;
    }

    Uint8List data = Uint8List(byteLength);

    int i = 0;
    for (; i < (binaryData.length >> 3); i++) {
      data[i] = int.parse(binaryData.substring(i << 3, (i << 3) + 8), radix: 2);
    }

    if (isNotMultiple8) {
      data[i] = data[i] = int.parse(binaryData.substring(i << 3), radix: 2) <<
          (8 - (binaryData.length & 7));
    }

    return data;
  }
}
