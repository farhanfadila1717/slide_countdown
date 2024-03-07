import 'package:flutter/foundation.dart';

/// {@template count_down_config}
/// `CountDownConfig` class contains configuration options for
/// count down durations.
/// {@endtemplate}
@immutable
class CountDownConfig {
  /// {@macro count_down_config}
  const CountDownConfig({
    required this.duration,
  });

  /// A Duration value that indicates the total duration of the count down.
  final Duration duration;

  @override
  String toString() => 'CountDownConfig(duration: $duration)';

  @override
  bool operator ==(covariant CountDownConfig other) {
    if (identical(this, other)) return true;

    return other.duration == duration;
  }

  @override
  int get hashCode => duration.hashCode;
}
