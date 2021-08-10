part of 'slide_countdown.dart';

class NotifiyDuration extends ValueNotifier<Duration> {
  NotifiyDuration(Duration value) : super(value);

  streamDuration(Duration duration) {
    value = duration;
    notifyListeners();
  }
}
