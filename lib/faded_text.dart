import 'dart:ui' as ui show Gradient;

import 'package:flutter/material.dart';

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

  /// The text to display as a [TextSpan].
  ///
  /// This will be null if [data] is provided instead.
  final InlineSpan? textSpan;

  /// The style to use for the text.
  ///
  /// If null, defaults [DefaultTextStyle] of context.
  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign? textAlign;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.Text.locale}
  final Locale? locale;

  /// {@macro flutter.painting.textPainter.textScaler}
  final TextScaler? textScaler;

  /// The required maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be faded.
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int maxLines;

  /// {@macro flutter.widgets.Text.semanticsLabel}
  final String? semanticsLabel;

  /// {@macro dart.ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
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

    double fadeEnd;
    double fadeStart;

    switch (textPainter.textDirection) {
      case TextDirection.rtl:
        fadeEnd = 0.0;
        fadeStart = textSize.width / 4;
      case TextDirection.ltr || null:
        fadeEnd = size.width;
        fadeStart = fadeEnd - textSize.width / 4;
    }

    return ui.Gradient.linear(
      Offset(fadeStart, 0),
      Offset(fadeEnd, 0),
      <Color>[const Color(0xFFFFFFFF), const Color(0x00FFFFFF)],
    );
  }
}
