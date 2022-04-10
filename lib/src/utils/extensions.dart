import 'dart:ui' show TextDirection;

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
