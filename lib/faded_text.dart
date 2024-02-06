import 'dart:ui' as ui show Gradient;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// The class for creating fading text in case of overflow.
class FadedText extends StatelessWidget {
  /// Creates a faded text widget.
  ///
  /// If the [style] argument is null, the text will use the style from the
  /// closest enclosing [DefaultTextStyle].
  const FadedText(
    String this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.maxLines = 1,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : textSpan = null;

  /// Creates a faded text widget with a [InlineSpan].
  const FadedText.rich(
    InlineSpan this.textSpan, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.maxLines = 1,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : data = null;

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String? data;

  /// The text to display as a [InlineSpan].
  ///
  /// This will be null if [data] is provided instead.
  final InlineSpan? textSpan;

  /// The style to use for the text.
  ///
  /// If null, defaults [DefaultTextStyle] of context.
  final TextStyle? style;

  /// The strut style to use. Strut style defines the strut, which sets minimum vertical layout metrics.
  ///
  /// Omitting or providing null will disable strut.
  ///
  /// Omitting or providing null for any properties of [StrutStyle] will result in default values being used.
  /// It is highly recommended to at least specify a [StrutStyle.fontSize].
  ///
  ///See [StrutStyle] for details.
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// The font scaling strategy to use when laying out and rendering the text.
  ///
  /// The value usually comes from [MediaQuery.textScalerOf], which typically
  /// reflects the user-specified text scaling value in the platform's
  /// accessibility settings. The [TextStyle.fontSize] of the text will be
  /// adjusted by the [TextScaler] before the text is laid out and rendered.
  final TextScaler? textScaler;

  /// The required maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be faded.
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// const Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String? semanticsLabel;

  /// Defines how to apply [TextStyle.height] over and under text.
  final TextHeightBehavior? textHeightBehavior;

  /// Defines how to measure the width of the rendered text.
  final TextWidthBasis? textWidthBasis;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    var effectiveTextStyle = style;

    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle!.merge(const TextStyle(fontWeight: FontWeight.bold));
    }

    return CustomPaint(
      size: Size.infinite,
      painter: _FadedTextPainer(
        textPainter: TextPainter(
          text: TextSpan(
            style: effectiveTextStyle,
            text: data,
            children: textSpan != null ? <InlineSpan>[textSpan!] : null,
            locale: locale,
            semanticsLabel: semanticsLabel,
          ),
          textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
          textDirection: textDirection ?? Directionality.of(context),
          // ignore: use_named_constants
          textScaler: textScaler == null ? const TextScaler.linear(1) : textScaler!,
          maxLines: maxLines,
          locale: locale,
          strutStyle: strutStyle,
          textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
          ellipsis: ' ',
          textHeightBehavior:
              textHeightBehavior ?? defaultTextStyle.textHeightBehavior ?? DefaultTextHeightBehavior.maybeOf(context),
        ),
      ),
    );
  }
}

class _FadedTextPainer extends CustomPainter {
  final TextPainter textPainter;

  const _FadedTextPainer({required this.textPainter});

  @override
  void paint(Canvas canvas, Size size) {
    const offset = Offset.zero;
    final overflowShader = _overflowShader(size);

    if (overflowShader != null) {
      // This layer limits what the shader below blends with to be just the
      // text (as opposed to the text and its background).
      canvas.saveLayer(offset & size, Paint());
    }

    textPainter.paint(canvas, offset);

    if (overflowShader == null) return;

    final paint = Paint()
      ..blendMode = BlendMode.modulate
      ..shader = overflowShader;

    final textLineHeight = textPainter.preferredLineHeight;

    canvas
      ..drawRect(Offset(0, textPainter.size.height - textLineHeight) & Size(size.width, textLineHeight), paint)
      ..restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  /// This method is used to create a gradient shader to fade the text.
  Shader? _overflowShader(Size size) {
    textPainter.layout(maxWidth: size.width);

    final textSize = textPainter.size;
    final textDidExceedMaxLines = textPainter.didExceedMaxLines;
    final didOverflowHeight = size.height < textSize.height || textDidExceedMaxLines;

    if (!didOverflowHeight) return null;

    final fadeSizePainter = TextPainter(
      text: TextSpan(style: textPainter.text?.style, text: '\u2026\u2026\u2026\u2026\u2026'),
      textDirection: textPainter.textDirection,
      textScaler: textPainter.textScaler,
      locale: textPainter.locale,
    )..layout();

    double fadeEnd;
    double fadeStart;

    switch (textPainter.textDirection) {
      case TextDirection.rtl:
        fadeEnd = 0.0;
        fadeStart = fadeSizePainter.width;
      case TextDirection.ltr || null:
        fadeEnd = size.width;
        fadeStart = fadeEnd - fadeSizePainter.width;
    }

    fadeSizePainter.dispose();

    return ui.Gradient.linear(
      Offset(fadeStart, 0),
      Offset(fadeEnd, 0),
      <Color>[const Color(0xFFFFFFFF), const Color(0x00FFFFFF)],
    );
  }
}
