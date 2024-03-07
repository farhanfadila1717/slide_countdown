import 'package:flutter/foundation.dart';
import 'package:slide_countdown/src/data/config/count_down_config.dart';
import 'package:slide_countdown/src/data/config/count_up_config.dart';

/// {@template stream_duration_config}
/// StreamDurationConfig class contains configuration options for
/// StreamDuration, which is a class that emits a stream of Duration values.
/// {@endtemplate}
@immutable
class StreamDurationConfig {
  /// {@macro stream_duration_config}
  const StreamDurationConfig({
    this.autoPlay = true,
    this.isCountUp = false,
    this.periodic = const Duration(seconds: 1),
    this.countDownConfig,
    this.countUpConfig,
    this.onDone,
  });

  /// A boolean value that indicates whether to automatically start emitting
  /// the Duration stream upon initialization of StreamDuration.
  /// The default value is true.
  final bool autoPlay;

  /// A boolean value that indicates whether the duration should increment or
  /// decrement.
  /// If true, the duration will increment, otherwise it will decrement.
  /// The default value is false.
  final bool isCountUp;

  /// A Duration value that indicates the interval at which the Duration stream
  /// should emit values.
  /// The default value is 1 second (Duration(seconds: 1)).
  final Duration periodic;

  /// {@macro count_down_config}
  /// this property required if isCountUp is false
  final CountDownConfig? countDownConfig;

  /// {@macro count_up_config}
  /// this property required if isCountUp is true
  final CountUpConfig? countUpConfig;

  /// When duration is count down duration is equal remainingDuration
  /// onDone will called
  ///
  /// Never called when `countUp` is `infinity` or `countUpAtDuration`
  final Function? onDone;

  @override
  bool operator ==(covariant StreamDurationConfig other) {
    if (identical(this, other)) return true;

    return other.autoPlay == autoPlay &&
        other.isCountUp == isCountUp &&
        other.periodic == periodic &&
        other.countDownConfig == countDownConfig &&
        other.countUpConfig == countUpConfig &&
        other.onDone == onDone;
  }

  @override
  int get hashCode {
    return autoPlay.hashCode ^
        isCountUp.hashCode ^
        periodic.hashCode ^
        countDownConfig.hashCode ^
        countUpConfig.hashCode ^
        onDone.hashCode;
  }

  @override
  String toString() => '''
StreamDurationConfig(
  autoPlay: $autoPlay, 
  isCountUp: $isCountUp, 
  periodic: $periodic, 
  countDownConfig: $countDownConfig, 
  countUpConfig: $countUpConfig, 
  onDone: $onDone
)''';
}
