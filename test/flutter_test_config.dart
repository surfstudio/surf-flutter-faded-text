import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Tolerance for golden tests with default value 0.18.
@protected
late final double toleranceForTesting;

Future<void> testExecutable(
  FutureOr<void> Function() testMain, {
  double tolerance = 0.18,
}) {
  toleranceForTesting = tolerance;
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();

      if (goldenFileComparator is LocalFileComparator) {
        goldenFileComparator = CustomFileComparator(
          '${(goldenFileComparator as LocalFileComparator).basedir}/goldens',
        );
      }
    },
    config: GoldenToolkitConfiguration(),
  );
}

/// Comparator for the golden file.
///
/// Allows specifying the tolerance for the golden file.
class CustomFileComparator extends LocalFileComparator {
  CustomFileComparator(String testFile) : super(Uri.parse(testFile));

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    if (!result.passed && result.diffPercent >= toleranceForTesting) {
      final error = await generateFailureOutput(result, golden, basedir);
      throw FlutterError(error);
    }
    if (!result.passed) {
      log(
        'A tolerable difference of ${result.diffPercent * 100}% was found when comparing $golden.',
        level: 2000,
      );
    }

    return result.passed || result.diffPercent <= toleranceForTesting;
  }
}
