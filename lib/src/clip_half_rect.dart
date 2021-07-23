part of 'slide_countdown.dart';

class ClipHalfRect extends CustomClipper<Rect> {
  final double percentage;
  final bool isUp;
  final SlideDirection slideDirection;

  ClipHalfRect({
    required this.percentage,
    required this.isUp,
    required this.slideDirection,
  });

  @override
  Rect getClip(Size size) {
    Rect _rect;
    if (slideDirection == SlideDirection.down) {
      if (isUp) {
        _rect = Rect.fromLTRB(
            0.0, size.height * -percentage, size.width, size.height);
      } else {
        _rect = Rect.fromLTRB(
          0.0,
          0.0,
          size.width,
          size.height * (1 - percentage),
        );
      }
    } else {
      if (isUp) {
        _rect =
            Rect.fromLTRB(0.0, size.height * (1 + percentage), size.width, 0.0);
      } else {
        _rect = Rect.fromLTRB(
            0.0, size.height * percentage, size.width, size.height);
      }
    }
    return _rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
