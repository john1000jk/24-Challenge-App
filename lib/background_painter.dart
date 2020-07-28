import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.indigo;

    var rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(rect, paint);

    paint.color = Colors.white;


    var path = Path();
    path..moveTo(size.width, 0)
      ..lineTo(0, 0)
    ..lineTo(0, size.height/2.5)
    ..cubicTo(size.width/3, size.height/3, 2*size.width/3, 2*size.height/3, size.width, size.height/3);

    canvas.drawPath(path, paint);

    paint.color = Colors.blue;

    var path2 = Path();
    path2..moveTo(0, size.height/2.5)
      ..cubicTo(size.width/3, size.height/3, 2*size.width/3, 4*size.height/7, size.width, 2*size.height/13)
    ..relativeLineTo(0, size.height/2)
    ..lineTo(0, 17*size.height/18);

    canvas.drawPath(path2, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
