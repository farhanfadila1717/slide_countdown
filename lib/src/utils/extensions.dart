import 'dart:ui' show TextDirection;

/// Extension class that extends the `TextDirection?`
/// type with a custom method `isRtl`.
extension TextDirectionExtension on TextDirection {
  /// A getter property that returns whether the text direction
  /// is Right-To-Left (RTL) or not.
  bool get isRtl => this == TextDirection.rtl;
}

extension DurationExtensions on Duration {
  String get inDaysAsString => inDays.toString();

  // Access the thousandth digit from inDays
  int get daysThousandDigit {
    if (inDays <= 0) return 0;
    return int.parse(inDaysAsString[inDaysAsString.length - 4]);
  }

  // Access the hundredth digit from inDays
  int get daysHundredDigit {
    if (inDays <= 0) return 0;
    return int.parse(inDaysAsString[inDaysAsString.length - 3]);
  }

  // Access the tens digit from inDays
  int get daysFirstDigit {
    if (inDays <= 0) return 0;
    if (inDays > 99) {
      return int.parse(inDaysAsString[inDaysAsString.length - 2]);
    }

    return inDays ~/ 10;
  }

  // Access the units digit from inDays
  int get daysLastDigit {
    if (inDays <= 0) return 0;

    if (inDays > 99) {
      return int.parse(inDaysAsString[inDaysAsString.length - 1]);
    }

    return inDays % 10;
  }

  int get hoursFirstDigit {
    if (inHours <= 0) return 0;
    return (inHours % 24) ~/ 10;
  }

  int get hoursSecondDigit {
    if (inHours <= 0) return 0;
    return (inHours % 24) % 10;
  }

  int get minutesFirstDigit {
    if (inMinutes <= 0) return 0;
    return (inMinutes % 60) ~/ 10;
  }

  int get minutesSecondDigit {
    if (inMinutes <= 0) return 0;
    return (inMinutes % 60) % 10;
  }

  int get secondsFirstDigit {
    if (inSeconds <= 0) return 0;
    return (inSeconds % 60) ~/ 10;
  }

  int get secondsSecondDigit {
    if (inSeconds <= 0) return 0;
    return (inSeconds % 60) % 10;
  }

  bool get isDaysHundred => inDays > 99;

  bool get isDaysThousand => inDays > 999;
}
