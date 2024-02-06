import 'package:faded_text/faded_text.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:test/scaffolding.dart';

void main() {
  const text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur siƒnt occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum';

  void testFadedText({required Widget widget, required String testName, required String goldenFileName}) {
    testGoldens(testName, (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [
          Device.phone,
          Device.iphone11,
          Device.tabletPortrait,
          Device.tabletLandscape,
        ])
        ..addScenario(widget: widget);
      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, goldenFileName);
    });
  }

  group('FadedText', () {
    group('Different colors', () {
      testFadedText(
        widget: const FadedText(text, maxLines: 3, style: TextStyle(fontSize: 24)),
        testName: 'FadedText - white background',
        goldenFileName: 'different_colors/faded_text/white_bg',
      );
      testFadedText(
        widget: const ColoredBox(
          color: Colors.black,
          child: FadedText(text, maxLines: 3, style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
        testName: 'FadedText - black background',
        goldenFileName: 'different_colors/faded_text/black_bg',
      );
      testFadedText(
        widget: const DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image_for_test.jpeg'),
              alignment: Alignment.topCenter,
              fit: BoxFit.contain,
            ),
          ),
          child: FadedText(text, maxLines: 3, style: TextStyle(fontSize: 24)),
        ),
        testName: 'FadedText - image background',
        goldenFileName: 'different_colors/faded_text/image_bg',
      );
    });
  });

  group('FadedText.rich', () {
    group('Different colors', () {
      testFadedText(
        widget: const FadedText.rich(
          TextSpan(
            children: [TextSpan(text: text), TextSpan(text: text, style: TextStyle(color: Colors.red))],
          ),
          style: TextStyle(fontSize: 24),
          maxLines: 7,
        ),
        testName: 'FadedText.rich - white background',
        goldenFileName: 'different_colors/faded_text_rich/white_bg',
      );
      testFadedText(
        widget: const ColoredBox(
          color: Colors.black,
          child: FadedText.rich(
            TextSpan(
              children: [
                TextSpan(text: text, style: TextStyle(color: Colors.white)),
                TextSpan(text: text, style: TextStyle(color: Colors.red)),
              ],
            ),
            style: TextStyle(fontSize: 24),
            maxLines: 7,
          ),
        ),
        testName: 'FadedText.rich - black background',
        goldenFileName: 'different_colors/faded_text_rich/black_bg',
      );
      testFadedText(
        widget: const DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image_for_test.jpeg'),
              alignment: Alignment.topCenter,
              fit: BoxFit.contain,
            ),
          ),
          child: FadedText.rich(
            TextSpan(
              children: [TextSpan(text: text), TextSpan(text: text, style: TextStyle(color: Colors.red))],
            ),
            style: TextStyle(fontSize: 24),
            maxLines: 6,
          ),
        ),
        testName: 'FadedText.rich - image background',
        goldenFileName: 'different_colors/faded_text_rich/image_bg',
      );
    });
  });
}
