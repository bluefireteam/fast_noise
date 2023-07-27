import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImagePane extends StatelessWidget {
  final bool loading;
  final ui.Image? image;

  const ImagePane({
    required this.loading,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    final image = this.image;
    if (image == null) {
      return const Center(
        child: Text('Click -generate- to generate a new image.'),
      );
    } else {
      return CustomPaint(
        painter: _CanvasScalePainter(image),
      );
    }
  }
}

class _CanvasScalePainter extends CustomPainter {
  _CanvasScalePainter(this.image);

  final ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    final srcSize = Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );
    final xScale = size.width / srcSize.width;
    final yScale = size.height / srcSize.height;
    final scale = min(xScale, yScale);
    final destSize = Size(
      srcSize.width * scale,
      srcSize.height * scale,
    );
    canvas.drawImageRect(
      image,
      Offset.zero & srcSize,
      Offset.zero & destSize,
      Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
