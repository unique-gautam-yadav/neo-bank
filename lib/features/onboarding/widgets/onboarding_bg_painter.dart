// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OnboardingBGPainter extends CustomPainter {
  final double radius;
  OnboardingBGPainter({
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..addOval(
        Rect.fromCircle(
          center: const Offset(50, -100),
          radius: radius,
        ),
      );

    canvas.drawShadow(
      path,
      Colors.pink.shade500,
      350,
      true,
    );
    Path path2 = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width - 100, size.height - 200),
          radius: radius,
        ),
      );

    canvas.drawShadow(
      path2,
      Colors.blue.shade500,
      200,
      true,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
