Implements FIPS 140-3 random generator tests.

## Features

1. Monobit test
2. Poker test
3. Runs test
4. Long run test

Additionally is able to perform monobit test for the bit string

## Getting started

1. Install Dart SDK and Flutter framework.
2. Install IDE (this was developed using Android studio, but any Dart-supporting will do).
3. Run command flutter test in project's folder in order to see that every thing is alright (all tests passed).

## Usage

For more sophisticated usage example see [example folder](./example/randomness_testing_example.dart)

One is able to run `monobitTest`, `runsTest`, `longRunsTest` or `pokerTest` for the generated 20000 bits (i.e. 2500 bytes)
For instance, for the `monobitTest` the code is the following

```dart
import 'dart:math' show Random;
//...
 void someValidationFunction() {
    var rand = Random.secure(); //one may use other random generator
    for (int i = 0; i < 2500; i++) {
      randomOutput[i] = rand.nextInt(256);
    }
    
    if (RandomnessTester.monobitTest(randomOutput)) {
      print("Generated sequence passed tests");
    } else {
      print("Generated sequence didn't pass tests");
    }
  }
```
