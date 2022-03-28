import 'dart:ui' show TextDirection;

enum SlideDirection { up, down }

enum SeparatorType { symbol, title }

extension TextDirectionExtension on TextDirection? {
  bool get isRtl {
    if (this == null) {
      return false;
    } else if (this == TextDirection.rtl) {
      return true;
    } else {
      return false;
    }
  }
}
