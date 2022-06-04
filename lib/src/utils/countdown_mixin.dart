import 'package:flutter/widgets.dart';

mixin CountdownMixin<T extends StatefulWidget> on State<T> {
  final ValueNotifier<int> daysFirstDigitNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> daysSecondDigitNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> hoursFirstDigitNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> hoursSecondDigitNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> minutesFirstDigitNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> minutesSecondDigitNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> secondsFirstDigitNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> secondsSecondDigitNotifier = ValueNotifier<int>(0);

  void _daysFirstDigitNotifier(Duration duration) {
    try {
      final int digit = daysFirstDigit(duration);

      if (digit != daysFirstDigitNotifier.value) {
        daysFirstDigitNotifier.value = digit;
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void _daysSecondDigitNotifier(Duration duration) {
    try {
      final int digit = daysSecondDigit(duration);
      if (digit != daysSecondDigitNotifier.value) {
        daysSecondDigitNotifier.value = digit;
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void _hoursFirstDigitNotifier(Duration duration) {
    try {
      final int digit = hoursFirstDigit(duration);
      if (digit != hoursFirstDigitNotifier.value) {
        hoursFirstDigitNotifier.value = digit;
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void _hoursSecondDigitNotifier(Duration duration) {
    try {
      final int digit = hoursSecondDigit(duration);

      if (digit != hoursSecondDigitNotifier.value) {
        hoursSecondDigitNotifier.value = digit;
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void _minutesFirstDigitNotifier(Duration duration) {
    try {
      final int digit = minutesFirstDigit(duration);

      if (digit != minutesFirstDigitNotifier.value) {
        minutesFirstDigitNotifier.value = digit;
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void _minutesSecondDigitNotifier(Duration duration) {
    try {
      final int digit = minutesSecondDigit(duration);
      if (digit != minutesSecondDigitNotifier.value) {
        minutesSecondDigitNotifier.value = digit;
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void _secondsFirstDigitNotifier(Duration duration) {
    try {
      final int digit = secondsFirstDigit(duration);
      if (digit != secondsFirstDigitNotifier.value) {
        secondsFirstDigitNotifier.value = digit;
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void _secondsSecondDigitNotifier(Duration duration) {
    try {
      final int digit = secondsSecondDigit(duration);
      if (digit != secondsSecondDigitNotifier.value) {
        secondsSecondDigitNotifier.value = digit;
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void disposeDaysNotifier() {
    daysFirstDigitNotifier.dispose();
    daysSecondDigitNotifier.dispose();
  }

  void disposeHoursNotifier() {
    hoursFirstDigitNotifier.dispose();
    hoursSecondDigitNotifier.dispose();
  }

  void disposeMinutesNotifier() {
    minutesFirstDigitNotifier.dispose();
    minutesSecondDigitNotifier.dispose();
  }

  void disposeSecondsNotifier() {
    secondsFirstDigitNotifier.dispose();
    secondsSecondDigitNotifier.dispose();
  }

  void updateValue(Duration duration) {
    _daysFirstDigitNotifier(duration);
    _daysSecondDigitNotifier(duration);

    _hoursFirstDigitNotifier(duration);
    _hoursSecondDigitNotifier(duration);

    _minutesFirstDigitNotifier(duration);
    _minutesSecondDigitNotifier(duration);

    _secondsFirstDigitNotifier(duration);
    _secondsSecondDigitNotifier(duration);
  }

  int daysFirstDigit(Duration duration) {
    if (duration.inDays <= 0) return 0;
    return duration.inDays ~/ 10;
  }

  int daysSecondDigit(Duration duration) {
    if (duration.inDays <= 0) return 0;
    return duration.inDays % 10;
  }

  int hoursFirstDigit(Duration duration) {
    if (duration.inHours <= 0) return 0;
    return (duration.inHours % 24) ~/ 10;
  }

  int hoursSecondDigit(Duration duration) {
    if (duration.inHours <= 0) return 0;
    return (duration.inHours % 24) % 10;
  }

  int minutesFirstDigit(Duration duration) {
    if (duration.inMinutes <= 0) return 0;
    return (duration.inMinutes % 60) ~/ 10;
  }

  int minutesSecondDigit(Duration duration) {
    if (duration.inMinutes <= 0) return 0;
    return (duration.inMinutes % 60) % 10;
  }

  int secondsFirstDigit(Duration duration) {
    if (duration.inSeconds <= 0) return 0;
    return (duration.inSeconds % 60) ~/ 10;
  }

  int secondsSecondDigit(Duration duration) {
    if (duration.inSeconds <= 0) return 0;
    return (duration.inSeconds % 60) % 10;
  }

  bool showWidget(int value, [bool force = false]) {
    if (force) return true;
    return value > 0;
  }

  @override
  void dispose() {
    disposeDaysNotifier();
    disposeHoursNotifier();
    disposeMinutesNotifier();
    disposeSecondsNotifier();
    super.dispose();
  }
}
