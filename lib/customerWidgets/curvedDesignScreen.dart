import 'package:flutter/material.dart';


class CurvedDesignScreen extends StatelessWidget {
  const CurvedDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // White Background
          Container(
            color: Colors.white,
          ),
          // Blue Curved Background
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              height: screenHeight*0.7, // Adjust the height of the blue section
              decoration: const BoxDecoration(
                color: Color.fromRGBO(18, 149, 117, 1)
              ),
            ),
          ),
          // Content on Top

        ],
      ),
    );
  }
}

// Custom Clipper for Blue Curved Background
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.5); // Start halfway down on the left
    path.quadraticBezierTo(
      size.width * 0.2, // Control point x (left curve control)
      size.height * 0.2, // Control point y (peak of the left curve)
      size.width * 0.6, // End x (center taper point)
      size.height * 0.3, // End y
    );
    path.quadraticBezierTo(
      size.width * 0.9, // Control point x (right taper control)
      size.height * 0.35, // Control point y
      size.width, // End x (right edge of the screen)
      size.height * 0.1, // End y (thin edge)
    );
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(0, 0); // Top-left corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
