import 'dart:ui' show TextDirection;

/// Extension class that extends the `TextDirection?`
/// type with a custom method `isRtl`.
extension TextDirectionExtension on TextDirection {
  /// A getter property that returns whether the text direction
  /// is Right-To-Left (RTL) or not.
  bool get isRtl {
    if (this == TextDirection.rtl) {
      return true;
    } else {
      return false;
    }
  }
}
