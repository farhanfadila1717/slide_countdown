import 'package:flutter/widgets.dart';

/// {@template countdown_mixin}
/// This is a Flutter Mixin that provides a countdown functionality for a StatefulWidget.
/// It uses ValueNotifier objects to notify changes in the values of the countdown.
/// The mixin provides notifiers for each digit of the countdown
/// for days, hours, minutes, and seconds. The update of each notifier
/// can be controlled using updateConfigurationNotifier method.
/// {@endtemplate}
mixin CountdownMixin<T extends StatefulWidget> on State<T> {
  /// Notifies the changes in the first digit of the days in the countdown.
  final ValueNotifier<int> daysFirstDigitNotifier = ValueNotifier<int>(0);

  /// Notifies the changes in the second digit of the days in the countdown.
  final ValueNotifier<int> daysSecondDigitNotifier = ValueNotifier<int>(0);

  /// Notifies the changes in the first digit of the hours in the countdown.
  final ValueNotifier<int> hoursFirstDigitNotifier = ValueNotifier<int>(0);

  /// Notifies the changes in the second digit of the hours in the countdown.
  final ValueNotifier<int> hoursSecondDigitNotifier = ValueNotifier<int>(0);

  /// Notifies the changes in the first digit of the minutes in the countdown.
  final ValueNotifier<int> minutesFirstDigitNotifier = ValueNotifier<int>(0);

  /// Notifies the changes in the second digit of the minutes in the countdown.
  final ValueNotifier<int> minutesSecondDigitNotifier = ValueNotifier<int>(0);

  /// Notifies the changes in the first digit of the seconds in the countdown.
  final ValueNotifier<int> secondsFirstDigitNotifier = ValueNotifier<int>(0);

  /// Notifies the changes in the second digit of the seconds in the countdown.
  final ValueNotifier<int> secondsSecondDigitNotifier = ValueNotifier<int>(0);

  bool _updateDaysNotifier = true;
  bool _updateHoursNotifier = true;
  bool _updateMinutesNotifier = true;
  bool _updateSecondsNotifier = true;
  bool _countInvisible = true;

  /// Update the flags that control the updates of each notifier.
  void updateConfigurationNotifier({
    bool? updateDaysNotifier,
    bool? updateHoursNotifier,
    bool? updateMinutesNotifier,
    bool? updateSecondsNotifier,
    bool? countInvisible,
  }) {
    if (updateDaysNotifier != null &&
        updateDaysNotifier != _updateDaysNotifier) {
      _updateDaysNotifier = updateDaysNotifier;
    }
    if (updateHoursNotifier != null &&
        updateHoursNotifier != _updateHoursNotifier) {
      _updateHoursNotifier = updateHoursNotifier;
    }
    if (updateMinutesNotifier != null &&
        updateMinutesNotifier != _updateMinutesNotifier) {
      _updateMinutesNotifier = updateMinutesNotifier;
    }
    if (updateSecondsNotifier != null &&
        updateSecondsNotifier != _updateSecondsNotifier) {
      _updateSecondsNotifier = updateSecondsNotifier;
    }
    if(countInvisible!=null){
      _countInvisible =countInvisible;
    }
  }

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
  List<int> values = <int>[TimeUnit.values.length];

  void updateValue(Duration duration) {
    // when the value of `_updateDaysNotifier` is false
    // there is no need to update the value in the days notifier
    if (_updateDaysNotifier) {
      _daysFirstDigitNotifier(duration);
      _daysSecondDigitNotifier(duration);
    }

    // when the value of `_updateHoursNotifier` is false
    // there is no need to update the value in the hours notifier
    if (_updateHoursNotifier) {
      _hoursFirstDigitNotifier(duration);
      _hoursSecondDigitNotifier(duration);
    }

    // when the value of `_updateMinutesNotifier` is false
    // there is no need to update the value in the minutes notifier
    if (_updateMinutesNotifier) {
      _minutesFirstDigitNotifier(duration);
      _minutesSecondDigitNotifier(duration);
    }

    // when the value of `_updateSecondsNotifier` is false
    // there is no need to update the value in the seconds notifier

    if (_updateSecondsNotifier) {
      _secondsFirstDigitNotifier(duration);
      _secondsSecondDigitNotifier(duration);
    }
  }

  int daysFirstDigit(Duration duration) {
    if (duration.inDays <= 0) return 0;
    return calcTime(TimeUnit.day, duration) ~/ 10;
  }

  int daysSecondDigit(Duration duration) {
    if (duration.inDays <= 0) return 0;
    return calcTime(TimeUnit.day, duration) % 10;
  }

  int hoursFirstDigit(Duration duration) {
    if (duration.inHours <= 0) return 0;
    return calcTime(TimeUnit.hour, duration) ~/ 10;
  }

  int hoursSecondDigit(Duration duration) {
    if (duration.inHours <= 0) return 0;
    return calcTime(TimeUnit.hour, duration) % 10;
  }

  int minutesFirstDigit(Duration duration) {
    if (duration.inMinutes <= 0) return 0;
    return calcTime(TimeUnit.minute, duration) ~/ 10;
  }

  int minutesSecondDigit(Duration duration) {
    if (duration.inMinutes <= 0) return 0;
    return calcTime(TimeUnit.minute, duration) % 10;
  }

  int secondsFirstDigit(Duration duration) {
    if (duration.inSeconds <= 0) return 0;
    return calcTime(TimeUnit.second, duration) ~/ 10;
  }

  int secondsSecondDigit(Duration duration) {
    if (duration.inSeconds <= 0) return 0;
    return calcTime(TimeUnit.second, duration) % 10;
  }

  int calcTime(TimeUnit timeUnit,Duration duration){
    int time = 0;
    for(int i=0;i<TimeUnit.values.length;i++){
      if(!_countInvisible){
        if(timeUnit!=TimeUnit.values[i]){
          continue;
        }
      }
      switch(TimeUnit.values[i]){
        case TimeUnit.day:
          time = duration.inDays;
          if(_updateDaysNotifier){
            if(timeUnit==TimeUnit.values[i]){
              return time;
            }
            time = 0;
          }
          break;
        case TimeUnit.hour:
          time =duration.inHours % 24+time*24;
          if(_updateHoursNotifier){
            if(timeUnit==TimeUnit.values[i]){
              return time;
            }
            time = 0;
          }
          break;
        case TimeUnit.minute:
          time =duration.inMinutes % 60+time*60;
          if(_updateMinutesNotifier){
            if(timeUnit==TimeUnit.values[i]){
              return time;
            }
            time = 0;
          }
          break;
        case TimeUnit.second:
          time =duration.inSeconds % 60+time*60;
          if(_updateSecondsNotifier){
            if(timeUnit==TimeUnit.values[i]){
              return time;
            }
            time = 0;
          }
          break;
        default:
          break;
      }
    }
    return time;
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

enum TimeUnit{
  day,
  hour,
  minute,
  second
}