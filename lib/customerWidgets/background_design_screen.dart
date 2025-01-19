import 'package:flutter/material.dart';
//BackgroundDesign

class BackgroundDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromRGBO(18, 149, 117, 0.2),
              Color.fromRGBO(18, 149, 117, 0.5),
              Color.fromRGBO(18, 149, 117, 0.9),
            ],
          ),
        ),
        child: CustomPaint(
          painter: AbstractShapePainter(),
        ),
      ),
    );
  }
}

class AbstractShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    // Draw the first abstract polygon
    Path path1 = Path();
    paint.color = Color.fromRGBO(255, 255, 255, 0.3);
    path1.moveTo(size.width * 0.1, size.height * 0.1);
    path1.lineTo(size.width * 0.7, size.height * 0.4);
    path1.lineTo(size.width * 0.1, size.height * 0.8);
    path1.close();
    canvas.drawPath(path1, paint);

    // Draw the second abstract polygon
    Path path2 = Path();
    paint.color = Colors.white.withOpacity(0.5);
    path2.moveTo(size.width * 0.6, size.height * 0.2);
    path2.lineTo(size.width * 0.8, size.height * 0.5);
    path2.lineTo(size.width * 0.3, size.height * 0.9);
    path2.close();
    canvas.drawPath(path2, paint);

    // Draw the third abstract polygon
    Path path3 = Path();
    paint.color = Colors.white.withOpacity(0.2);
    path3.moveTo(size.width * 0.1, size.height * 0.5);
    path3.lineTo(size.width * 0.5, size.height * 0.7);
    path3.lineTo(size.width * 0.9, size.height * 0.3);
    path3.close();
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
