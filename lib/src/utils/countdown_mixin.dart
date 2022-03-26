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

  void daysFirstDigit(Duration duration) {
    try {
      if (duration.inDays == 0) {
        daysFirstDigitNotifier.value = 0;
        return;
      } else {
        int calculate = (duration.inDays) ~/ 10;
        if (calculate != daysFirstDigitNotifier.value) {
          daysFirstDigitNotifier.value = calculate;
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void daysSecondDigit(Duration duration) {
    try {
      if (duration.inDays == 0) {
        daysSecondDigitNotifier.value = 0;
        return;
      } else {
        int calculate = (duration.inDays) % 10;
        if (calculate != daysSecondDigitNotifier.value) {
          daysSecondDigitNotifier.value = calculate;
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void hoursFirstDigit(Duration duration) {
    try {
      if (duration.inHours == 0) {
        hoursFirstDigitNotifier.value = 0;
        return;
      } else {
        int calculate = (duration.inHours % 24) ~/ 10;
        if (calculate != hoursFirstDigitNotifier.value) {
          hoursFirstDigitNotifier.value = calculate;
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void hoursSecondDigit(Duration duration) {
    try {
      if (duration.inHours == 0) {
        hoursSecondDigitNotifier.value = 0;
        return;
      } else {
        int calculate = (duration.inHours % 24) % 10;
        if (calculate != hoursSecondDigitNotifier.value) {
          hoursSecondDigitNotifier.value = calculate;
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void minutesFirstDigit(Duration duration) {
    try {
      if (duration.inMinutes == 0) {
        minutesFirstDigitNotifier.value = 0;
        return;
      } else {
        int calculate = (duration.inMinutes % 60) ~/ 10;
        if (calculate != minutesFirstDigitNotifier.value) {
          minutesFirstDigitNotifier.value = calculate;
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void minutesSecondDigit(Duration duration) {
    try {
      if (duration.inMinutes == 0) {
        minutesSecondDigitNotifier.value = 0;
        return;
      } else {
        int calculate = (duration.inMinutes % 60) % 10;
        if (calculate != minutesSecondDigitNotifier.value) {
          minutesSecondDigitNotifier.value = calculate;
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void secondsFirstDigit(Duration duration) {
    try {
      if (duration.inSeconds == 0) {
        secondsFirstDigitNotifier.value = 0;
        return;
      } else {
        int calculate = (duration.inSeconds % 60) ~/ 10;
        if (calculate != secondsFirstDigitNotifier.value) {
          secondsFirstDigitNotifier.value = calculate;
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void secondsSecondDigit(Duration duration) {
    try {
      if (duration.inSeconds == 0) {
        secondsSecondDigitNotifier.value = 0;
        return;
      } else {
        int calculate = (duration.inSeconds % 60) % 10;
        if (calculate != secondsSecondDigitNotifier.value) {
          secondsSecondDigitNotifier.value = calculate;
        }
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
    daysFirstDigit(duration);
    daysSecondDigit(duration);

    hoursFirstDigit(duration);
    hoursSecondDigit(duration);

    minutesFirstDigit(duration);
    minutesSecondDigit(duration);

    secondsFirstDigit(duration);
    secondsSecondDigit(duration);
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
