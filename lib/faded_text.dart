import 'dart:ui' as ui show Gradient;

import 'package:flutter/material.dart';

/// {@template faded_text.class}
/// The class for creating fading text in case of overflow.
/// {@endtemplate}
class FadedText extends StatelessWidget {
  /// An object that paints a text.
  final TextPainter textPainter;

  /// {@macro faded_text.class}
  FadedText(
    String data, {
    super.key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextDirection textDirection = TextDirection.ltr,
    Locale? locale,
    double textScaleFactor = 1.0,
    TextScaler textScaler = TextScaler.noScaling,
    int maxLines = 1,
    String? semanticsLabel,
    TextWidthBasis textWidthBasis = TextWidthBasis.parent,
    TextHeightBehavior? textHeightBehavior,
  }) : textPainter = TextPainter(
          text: TextSpan(
            text: data,
            style: style,
            locale: locale,
            semanticsLabel: semanticsLabel,
          ),
          textAlign: textAlign,
          textDirection: textDirection,
          textScaler: textScaler == TextScaler.noScaling ? TextScaler.linear(textScaleFactor) : textScaler,
          maxLines: maxLines,
          locale: locale,
          strutStyle: strutStyle,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _FadedTextPainer(textPainter: textPainter, constraints: constraints),
        );
      },
    );
  }
}

class _FadedTextPainer extends CustomPainter {
  final TextPainter textPainter;
  final BoxConstraints constraints;

  const _FadedTextPainer({required this.textPainter, required this.constraints});

  @override
  void paint(Canvas canvas, Size size) {
    const offset = Offset.zero;
    final overflowShader = _overflowShader();

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
  Shader? _overflowShader() {
    textPainter.layout(maxWidth: constraints.maxWidth);

    final textSize = textPainter.size;
    final textDidExceedMaxLines = textPainter.didExceedMaxLines;
    final size = constraints.constrain(textSize);
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
