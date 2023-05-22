import 'dart:math';
import 'dart:typed_data';
import 'package:grizzly_distuv/math.dart';

/// Checks if you are awesome. Spoiler: you are.
class RandomnessTester {
  ///Implements monobit test
  bool monobitTest(Uint8List data) {
    int s = 0;
    for(int i = 0; i < data.length; i++) {
      for (int mask = 0x80; mask != 0; mask = mask >> 1) {
        (mask & data[i]) == 0 ? s-- : s++;
      }
    }

    if(s < 0) {
      s = -1 * s;
    }

    double sObs = s / sqrt(data.length * 8);

    double pValue = erfc(sObs/sqrt(2));

    return pValue < 0.01;
  }
}
