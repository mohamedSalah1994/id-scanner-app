import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  ui.Image image;
  List<Rect> rects;
  Painter(this.rects, this.image);
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = Colors.yellow;

    canvas.drawImage(image, const Offset(0, 0), paint);

    for (var rect in rects) {
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
