import 'package:flutter/rendering.dart';
import 'enum.dart';

class ClipHalfRect extends CustomClipper<Rect> {
  final double percentage;
  final bool isUp;
  final SlideDirection slideDirection;

  const ClipHalfRect({
    required this.percentage,
    required this.isUp,
    required this.slideDirection,
  });

  @override
  Rect getClip(Size size) {
    Rect rect;
    if (slideDirection == SlideDirection.down) {
      if (isUp) {
        rect = Rect.fromLTRB(
            0.0, size.height * -percentage, size.width, size.height);
      } else {
        rect = Rect.fromLTRB(
          0.0,
          0.0,
          size.width,
          size.height * (1 - percentage),
        );
      }
    } else {
      if (isUp) {
        rect =
            Rect.fromLTRB(0.0, size.height * (1 + percentage), size.width, 0.0);
      } else {
        rect = Rect.fromLTRB(
            0.0, size.height * percentage, size.width, size.height);
      }
    }
    return rect;
  }

  @override
  bool shouldReclip(ClipHalfRect oldClipper) =>
      percentage != oldClipper.percentage ||
      isUp != oldClipper.isUp ||
      slideDirection != oldClipper.slideDirection;
}
