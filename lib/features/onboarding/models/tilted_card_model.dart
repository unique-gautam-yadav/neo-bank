import 'package:flutter/material.dart';

class TiltedCardModel {
  Offset tiltOffset;
  double angle;
  Offset position;
  TiltedCardModel({
    required this.tiltOffset,
    required this.angle,
    required this.position,
  });
}
