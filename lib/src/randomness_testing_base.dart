import 'dart:math';
import 'dart:typed_data';
import 'package:grizzly_distuv/math.dart';

/// Checks if you are awesome. Spoiler: you are.
class RandomnessTester {
  ///Implements monobit test
  static bool monobitTest(Uint8List data, [int? bitLength]) {
    bitLength ??= data.length << 3; //i.e. data is fully staffed

    if(bitLength > (data.length << 3)) {
      throw ArgumentError("RandomnessTester: data is shorter provided bitLength");
    }

    if(bitLength < (data.length << 3) - 7) {
      throw ArgumentError("RandomnessTester: data is longer provided bitLength");
    }

    int s = 0;
    for(int i = 0; i < data.length; i++) {
      for (int mask = 0x80; mask != 0 || bitLength == 0; mask = mask >> 1) {
        (mask & data[i]) == 0 ? s-- : s++;
        bitLength = bitLength! - 1;
      }
    }

    if(s < 0) {
      s = -1 * s;
    }

    double sObs = s / sqrt(data.length * 8);

    double pValue = erfc(sObs/sqrt(2));

    return pValue >= 0.01;
  }
}
