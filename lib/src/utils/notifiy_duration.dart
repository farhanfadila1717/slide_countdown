import 'package:flutter/foundation.dart';

/// {@template notify_duration}
/// A [ValueNotifier] that wraps a [Duration].
/// {@endtemplate}
class NotifiyDuration extends ValueNotifier<Duration> {
  /// {@macro notify_duration}
  NotifiyDuration(super.value);

  /// Updates the value of [Duration].
  streamDuration(Duration duration) {
    value = duration;
    notifyListeners();
  }
}
