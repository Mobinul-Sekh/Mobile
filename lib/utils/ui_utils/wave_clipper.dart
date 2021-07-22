import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height * 0.85);
    path.quadraticBezierTo(
      size.width * 0.175,
      size.height,
      size.width * 0.25,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.375,
      size.height * 0.35,
      size.width * 0.55,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.85,
      size.width,
      size.height * 0.5,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
