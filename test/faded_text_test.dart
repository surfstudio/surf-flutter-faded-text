import 'package:faded_text/faded_text.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:test/scaffolding.dart';

void main() {
  const text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur siƒnt occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum';

  void testFadedText({
    required Widget widget,
    required String testName,
    required String goldenFileName,
  }) {
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
        widget:
            const FadedText(text, maxLines: 3, style: TextStyle(fontSize: 24)),
        testName: 'FadedText - white background',
        goldenFileName: 'different_colors/faded_text/white_bg',
      );
      testFadedText(
        widget: const ColoredBox(
          color: Colors.black,
          child: FadedText(text,
              maxLines: 3, style: TextStyle(fontSize: 24, color: Colors.white)),
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

    group('Different text size and height', () {
      testFadedText(
        widget: const FadedText(text,
            maxLines: 2, style: TextStyle(fontSize: 16, height: 1.5)),
        testName: 'FadedText - small size',
        goldenFileName: 'different_sizes/faded_text/small_size',
      );
      testFadedText(
        widget: const FadedText(text,
            maxLines: 3, style: TextStyle(fontSize: 32, height: 2)),
        testName: 'FadedText - medium size',
        goldenFileName: 'different_sizes/faded_text/medium_size',
      );
      testFadedText(
        widget: const FadedText(text,
            maxLines: 3, style: TextStyle(fontSize: 64, height: 2.5)),
        testName: 'FadedText - large size',
        goldenFileName: 'different_sizes/faded_text/large_size',
      );
    });

    group('Different scale', () {
      testFadedText(
        widget: const FadedText(
          text,
          maxLines: 2,
          style: TextStyle(fontSize: 24),
          textScaler: TextScaler.linear(2),
        ),
        testName: 'FadedText - scale 2',
        goldenFileName: 'different_scale/faded_text/scale_2',
      );
      testFadedText(
        widget: const FadedText(
          text,
          maxLines: 3,
          style: TextStyle(fontSize: 24),
          textScaler: TextScaler.linear(4),
        ),
        testName: 'FadedText - scale 4',
        goldenFileName: 'different_scale/faded_text/scale_4',
      );
      testFadedText(
        widget: const FadedText(
          text,
          maxLines: 3,
          style: TextStyle(fontSize: 24),
          textScaler: TextScaler.linear(6),
        ),
        testName: 'FadedText - scale 6',
        goldenFileName: 'different_scale/faded_text/scale_6',
      );
    });

    group('Different text direction', () {
      testFadedText(
        widget: const FadedText(text,
            maxLines: 2,
            style: TextStyle(fontSize: 24),
            textDirection: TextDirection.ltr),
        testName: 'FadedText - TextDirection.ltr',
        goldenFileName: 'different_text_direction/faded_text/ltr',
      );
      testFadedText(
        widget: const FadedText(text,
            maxLines: 3,
            style: TextStyle(fontSize: 24),
            textDirection: TextDirection.rtl),
        testName: 'FadedText - TextDirection.rtl',
        goldenFileName: 'different_text_direction/faded_text/rtl',
      );
    });
  });

  group('FadedText.rich', () {
    group('Different colors', () {
      testFadedText(
        widget: const FadedText.rich(
          TextSpan(
            children: [
              TextSpan(text: text),
              TextSpan(
                  text: text,
                  style:
                      TextStyle(color: Colors.red, fontStyle: FontStyle.italic))
            ],
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
                TextSpan(
                    text: text,
                    style: TextStyle(
                        color: Colors.red, fontStyle: FontStyle.italic)),
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
              children: [
                TextSpan(text: text),
                TextSpan(
                    text: text,
                    style: TextStyle(
                        color: Colors.red, fontStyle: FontStyle.italic))
              ],
            ),
            style: TextStyle(fontSize: 24),
            maxLines: 6,
          ),
        ),
        testName: 'FadedText.rich - image background',
        goldenFileName: 'different_colors/faded_text_rich/image_bg',
      );
    });

    group('Different text size and height', () {
      testFadedText(
        widget: const FadedText.rich(
          TextSpan(
            children: [
              TextSpan(text: text),
              TextSpan(
                  text: text,
                  style:
                      TextStyle(color: Colors.red, fontStyle: FontStyle.italic))
            ],
          ),
          style: TextStyle(fontSize: 16, height: 1.5),
          maxLines: 4,
        ),
        testName: 'FadedText.rich - small size',
        goldenFileName: 'different_sizes/faded_text_rich/small_size',
      );
      testFadedText(
        widget: const FadedText.rich(
          TextSpan(
            children: [
              TextSpan(text: text),
              TextSpan(
                  text: text,
                  style:
                      TextStyle(color: Colors.red, fontStyle: FontStyle.italic))
            ],
          ),
          style: TextStyle(fontSize: 32, height: 2),
          maxLines: 7,
        ),
        testName: 'FadedText.rich - medium size',
        goldenFileName: 'different_sizes/faded_text_rich/medium_size',
      );
      testFadedText(
        widget: const FadedText.rich(
          TextSpan(
            children: [
              TextSpan(text: text),
              TextSpan(
                  text: text,
                  style:
                      TextStyle(color: Colors.red, fontStyle: FontStyle.italic))
            ],
          ),
          style: TextStyle(fontSize: 64, height: 2.5),
          maxLines: 4,
        ),
        testName: 'FadedText.rich - large size',
        goldenFileName: 'different_sizes/faded_text_rich/large_size',
      );
    });

    group('Different scale', () {
      testFadedText(
        widget: FadedText.rich(
          TextSpan(
            children: [
              TextSpan(text: text.substring(0, 50)),
              TextSpan(
                text: text.substring(50, text.length),
                style: const TextStyle(
                    color: Colors.red, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          style: const TextStyle(fontSize: 24),
          textScaler: const TextScaler.linear(2),
          maxLines: 4,
        ),
        testName: 'FadedText.rich - scale 2',
        goldenFileName: 'different_scale/faded_text_rich/scale_2',
      );
      testFadedText(
        widget: FadedText.rich(
          TextSpan(
            children: [
              TextSpan(text: text.substring(0, 50)),
              TextSpan(
                text: text.substring(50, text.length),
                style: const TextStyle(
                    color: Colors.red, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          style: const TextStyle(fontSize: 24),
          textScaler: const TextScaler.linear(4),
          maxLines: 4,
        ),
        testName: 'FadedText.rich  - scale 4',
        goldenFileName: 'different_scale/faded_text_rich/scale_4',
      );
      testFadedText(
        widget: FadedText.rich(
          TextSpan(
            children: [
              TextSpan(text: text.substring(0, 20)),
              TextSpan(
                text: text.substring(20, text.length),
                style: const TextStyle(
                    color: Colors.red, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          style: const TextStyle(fontSize: 24),
          textScaler: const TextScaler.linear(6),
          maxLines: 3,
        ),
        testName: 'FadedText.rich  - scale 6',
        goldenFileName: 'different_scale/faded_text_rich/scale_6',
      );
    });

    group('Different text direction', () {
      testFadedText(
        widget: const FadedText.rich(
          TextSpan(
            children: [
              TextSpan(text: text),
              TextSpan(
                  text: text,
                  style:
                      TextStyle(color: Colors.red, fontStyle: FontStyle.italic))
            ],
          ),
          style: TextStyle(fontSize: 24),
          maxLines: 7,
          textDirection: TextDirection.ltr,
        ),
        testName: 'FadedText.rich - TextDirection.ltr',
        goldenFileName: 'different_text_direction/faded_text_rich/ltr',
      );
      testFadedText(
        widget: const FadedText.rich(
          TextSpan(
            children: [
              TextSpan(text: text),
              TextSpan(
                  text: text,
                  style:
                      TextStyle(color: Colors.red, fontStyle: FontStyle.italic))
            ],
          ),
          style: TextStyle(fontSize: 24),
          maxLines: 7,
          textDirection: TextDirection.rtl,
        ),
        testName: 'FadedText.rich - TextDirection.rtl',
        goldenFileName: 'different_text_direction/faded_text_rich/rtl',
      );
    });
  });
}
