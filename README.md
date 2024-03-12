<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/surfstudio/surf-flutter-faded-text/assets/54618146/71c4a82d-f93e-427c-9683-dc2e71203f47">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/surfstudio/surf-flutter-faded-text/assets/54618146/2683a722-0068-4a45-9e35-90480f41b836">
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/surfstudio/surf-flutter-faded-text/assets/54618146/2683a722-0068-4a45-9e35-90480f41b836">
</picture>

<br></br>

[![Build Status](https://shields.io/github/actions/workflow/status/surfstudio/surf-flutter-faded-text/main.yml?logo=github&logoColor=white)](https://github.com/surfstudio/surf-flutter-faded-text)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/surf-flutter-faded-text?logo=codecov&logoColor=white)](https://app.codecov.io/gh/surfstudio/surf-flutter-faded-text)
[![Pub Version](https://img.shields.io/pub/v/faded-text?logo=dart&logoColor=white)](https://pub.dev/packages/faded_text)
[![Pub Likes](https://badgen.net/pub/likes/faded_text)](https://pub.dev/packages/faded_text)
[![Pub popularity](https://badgen.net/pub/popularity/faded_text)](https://pub.dev/packages/faded_text/score)
[![License: Apache 2.0](https://img.shields.io/badge/license-apache-purple.svg)](https://www.apache.org/licenses/LICENSE-2.0)

Enhance your Flutter app with this package, designed to seamlessly integrate left-to-right fade effects for multi-line text. Perfect for when you need that single-line text elegance in more complex layouts. Made by [Surf :surfer:](https://surf.dev/flutter/) Flutter team :cow2:

## Description 

- :1234: Enabled on every platform - the package is fully written on Flutter side and enabled on every platform
- :recycle: Fully covered by tests - guaranteeing the result and expectations from this package
- :notebook_with_decorative_cover: End-to-end documentation - every aspect of implementation is documented, so there is full understanding
- :cow2: Support from the best Flutter experts - we are open to any enhancement ideas and contributions

## Usage

### Installation

Add `faded_text` to your `pubspec.yaml` file:

```yaml
dependencies:
  faded_text: 0.0.6
```

### Example

You need to create an instance of the `FadedText` class like a regular `Text`.

<table>
<tr>
  <th>Regular `Text` with fade effect</th>
  <th>`FadedText`</th>
</tr>
<tr>
  <td>

  ```dart
  Text(
    'Lorem ipsum dolor sit amet, 
    consectetur adipisci and blah blah...',
    maxLines: 5,
    overflow: TextOverflow.fade,
  )
  ```
  </td>
  <td>

  ```dart
  FadedText(
    'Lorem ipsum dolor sit amet, 
    consectetur adipisci and blah blah...',
    maxLines: 5,
  )
  ```
  </td>
</tr>
</table>

Output:

<table>
  <tr>
    <th>Fade effect of intrinsic `Text`</th>
    <th>Fade effect of `FadedText`</th>
  </tr>
  <tr>
    <td>
      <img src="https://i.ibb.co/dLghB0q/example-text.png">
    </td>
    <td>
      <img src="https://i.ibb.co/3vjgKJg/example-faded-text.png">
    </td>
  </tr>
</table>


You can also create `FadedText.rich` like regular `Text.rich`.

<table>
<tr>
  <th>Regular `Tex.rich` with fade effect</th>
  <th>`FadedText.rich`</th>
</tr>
<tr>
  <td>

  ```dart
  Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text:
            'Lorem ipsum dolor sit amet, 
            consectetur adipisci 
            and blah blah...',
          ),
        TextSpan(
          text:
            'Ut enim ad minim veniam, 
            quis nostrud and so on...',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      maxLines: 4,
      overflow: TextOverflow.fade,
    ),
  ```
  </td>
  <td>

  ```dart
  FadedText.rich(
    TextSpan(
      children: [
        TextSpan(
          text:
            'Lorem ipsum dolor sit amet,   
            consectetur adipisci and blah blah...'),
        TextSpan(
          text:
            'Ut enim ad minim veniam, 
            quis nostrud and so on...',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    maxLines: 4,
  )
  ```
  </td>
</tr>
</table>

Output:

<table>
  <tr>
    <th>Fade effect of intrinsic Text.rich</th>
    <th>Fade effect of FadedText.rich</th>
  </tr>
  <tr>
    <td>
      <img src="https://i.ibb.co/PznwK7t/example-text-rich.png">
    </td>
    <td>
      <img src="https://i.ibb.co/hM0Kk3g/example-faded-text-rich.png">
    </td>
  </tr>
</table>



## Changelog

All notable changes to this project will be documented [here](./CHANGELOG.md).

## Issues

To report your issues, file directly in the [Issues](https://github.com/surfstudio/faded-text/issues) section.

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, fixing a bug or adding a cool new feature), please read our [contribution guide](./CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
