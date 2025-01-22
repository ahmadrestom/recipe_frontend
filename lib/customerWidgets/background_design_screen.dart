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
          color: Colors.white
        ),
        child: CustomPaint(
          painter: AbstractShapePainter(),
        ),
      ),
    );
  }
}

/*gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromRGBO(18, 149, 117, 0.2),
              Color.fromRGBO(18, 149, 117, 0.5),
              Color.fromRGBO(18, 149, 117, 0.9),
            ],
          ),*/

class AbstractShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    Path path1 = Path();
    paint.color = Color.fromRGBO(18, 149, 117, 0.15);
    path1.moveTo(size.width * 0, size.height * 1);
    path1.lineTo(size.width * 1, size.height * 1);
    path1.lineTo(size.width * 1, size.height * 0.6);
    path1.close();
    canvas.drawPath(path1, paint);

    Path path2 = Path();
    paint.color = Color.fromRGBO(18, 149, 117, 0.12);
    path2.moveTo(size.width * -0.5, size.height * 1);
    path2.lineTo(size.width * 1, size.height * 1);
    path2.lineTo(size.width * 1, size.height * 0.6);
    path2.close();
    canvas.drawPath(path2, paint);

    Path path3 = Path();
    paint.color = Color.fromRGBO(18, 149, 117, 0.12);
    path3.moveTo(size.width * 0, size.height * 0.6);
    path3.lineTo(size.width * 1, size.height * 1);
    path3.lineTo(size.width * 0.0, size.height * 1);
    path3.close();
    canvas.drawPath(path3, paint);

    Path path4 = Path();
    paint.color = Color.fromRGBO(18, 149, 117, 0.1);
    path4.moveTo(size.width * 0, size.height * 1);
    path4.lineTo(size.width * 0.5, size.height * 1);
    path4.lineTo(size.width * 1, size.height * 0.4);
    path4.close();
    canvas.drawPath(path4, paint);

    Path path5 = Path();
    paint.color = Color.fromRGBO(18, 149, 117, 0.09);
    path5.moveTo(size.width * 0, size.height * 0.3);
    path5.lineTo(size.width * 0, size.height * 1);
    path5.lineTo(size.width * 1, size.height * 1);
    path5.close();
    canvas.drawPath(path5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
