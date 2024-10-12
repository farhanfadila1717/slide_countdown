import 'package:flutter/material.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:slide_countdown/src/data/config/config.dart';

/// @nodoc
class StreamDuration extends ValueNotifier<Duration> {
  /// @nodoc
  StreamDuration({
    required this.config,
  }) : super(config.duration) {
    if (config.autoPlay) play();
  }

  /// @nodoc
  final StreamDurationConfig config;

  /// @nodoc
  bool get isCountUp => config.isCountUp;

  /// @nodoc
  bool get isPaused => _timer?.isPaused ?? false;

  PausableTimer? _timer;

  CountUpConfig get _countUpConfig =>
      config.countUpConfig ?? CountUpConfig.defaultConfig;

  ///
  bool get isFinished {
    if (!isCountUp && value.inSeconds <= 0) return true;

    return isCountUp &&
        !_countUpConfig.isInfinity &&
        value >= _countUpConfig.maxDuration!;
  }

  void _onDone() {
    _timer?.pause();
    // ignore: avoid_dynamic_calls
    config.onDone?.call();
  }

  /// Play
  void play() {
    _timer = PausableTimer.periodic(
      config.periodic,
      () {
        if (isCountUp) {
          value += config.periodic;
        } else {
          value -= config.periodic;
        }
        notifyListeners();
        if (isFinished) _onDone();
      },
    );
    _timer?.start();
  }

  /// pause duration
  void pause() => _timer?.pause();

  /// reset duration to initial duration
  void reset() {
    value = config.duration;
    notifyListeners();
  }

  /// resume duration
  void resume() => _timer?.start();

  /// change
  @Deprecated('use seek instead')
  void change(Duration duration) {
    value = duration;
    notifyListeners();
  }

  /// seek to
  void seek(Duration duration) {
    value = duration;
    notifyListeners();
  }

  /// subtract duration
  void subtract(Duration duration) {
    value -= duration;
    notifyListeners();
  }

  /// add duration
  void add(Duration duration) {
    value += duration;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// extension for StreamDurationConfig
extension StreamDurationConfigExtensions on StreamDurationConfig {
  /// @nodoc
  Duration get duration =>
      isCountUp ? initialCountUpDuration : initialCountDownDuration;

  /// @nodoc
  Duration get initialCountUpDuration =>
      countUpConfig?.initialDuration ?? Duration.zero;

  /// @nodoc
  Duration get initialCountDownDuration {
    if (countDownConfig == null) {
      throw Exception("countDownConfig can't be null");
    }
    return countDownConfig!.duration;
  }
}
