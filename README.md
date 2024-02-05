# Faded Text

[![Build Status](https://shields.io/github/actions/workflow/status/surfstudio/faded-text/main.yml?logo=github&logoColor=white)](https://github.com/surfstudio/faded-text)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/faded-text?logo=codecov&logoColor=white)](https://app.codecov.io/gh/surfstudio/faded-text)
[![Pub Version](https://img.shields.io/pub/v/faded_text?logo=dart&logoColor=white)](https://pub.dev/packages/faded_text)
[![Pub Likes](https://badgen.net/pub/likes/faded_text)](https://pub.dev/packages/faded_text)
[![Pub popularity](https://badgen.net/pub/popularity/faded_text)](https://pub.dev/packages/faded_text/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/faded_text)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru).

[![Faded Text](https://i.ibb.co/Wn4rtcS/Faded-Text.png)](https://github.com/surfstudio/SurfGear)

## Description

Faded Text is a package that allows you to create a fading text in case of overflow.

## Installation

Add `faded_text` to your `pubspec.yaml` file:

```yaml
dependencies:
  faded_text: $currentVersion$
```

<p>At this moment, the current version of <code>faded_text</code> is <a href="https://pub.dev/packages/faded_text"><img style="vertical-align:middle;" src="https://img.shields.io/pub/v/faded_text.svg" alt="faded_text version"></a>.</p>

## Example

You need to create an instance of the `FadedText` class like a regular `Text`. The text will overflow according to `maxLines`, which by default corresponds to 1. If you do not specify the text color, it will be white by default.

```dart
  FadedText(
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur siƒnt occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
    maxLines: 5,
    style: const TextStyle(color: Colors.black),
  )
```

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

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