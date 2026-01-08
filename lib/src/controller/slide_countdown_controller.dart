import 'package:flutter/foundation.dart';
import 'package:pausable_timer/pausable_timer.dart';

/// Enum representing the current state of the countdown timer.
enum SlideCountdownState {
  /// Timer has not been started yet.
  notStarted,

  /// Timer is currently running.
  running,

  /// Timer is paused.
  paused,

  /// Timer has completed (reached zero for countdown or max for count-up).
  completed;

  /// A human-readable description of the current state.
  String get description {
    switch (this) {
      case SlideCountdownState.notStarted:
        return 'Not Started';
      case SlideCountdownState.running:
        return 'Running';
      case SlideCountdownState.paused:
        return 'Paused';
      case SlideCountdownState.completed:
        return 'Completed';
    }
  }
}

/// {@template slide_countdown_controller}
/// A controller for managing the countdown timer state.
///
/// The controller provides methods to control the countdown timer:
/// - [start] - Starts the countdown timer
/// - [pause] - Pauses the countdown timer
/// - [resume] - Resumes a paused countdown timer
/// - [stop] - Stops the countdown timer and resets to initial duration
/// - [reset] - Resets the countdown timer to initial duration
/// - [setDuration] - Changes the countdown duration
///
/// Example usage:
///
/// ```dart
/// final controller = SlideCountdownController();
///
/// SlideCountdown(
///   controller: controller,
///   duration: const Duration(minutes: 5),
/// );
///
/// // Control the countdown
/// controller.start();
/// controller.pause();
/// controller.resume();
/// controller.reset();
/// controller.stop();
///
/// // Change duration
/// controller.setDuration(const Duration(minutes: 10));
///
/// // Don't forget to dispose
/// controller.dispose();
/// ```
/// {@endtemplate}
class SlideCountdownController extends ChangeNotifier
    implements ValueListenable<Duration> {
  /// {@macro slide_countdown_controller}
  SlideCountdownController({
    Duration? duration,
    Duration? initialDuration,
    bool autoPlay = true,
    bool countUp = false,
    Duration? maxDuration,
    this.periodic = const Duration(seconds: 1),
    this.onDone,
  })  : _duration = duration ?? Duration.zero,
        _initialDuration = initialDuration,
        _isCountUp = countUp,
        _maxDuration = maxDuration,
        _value = _calculateInitialValue(
          countUp: countUp,
          duration: duration,
          initialDuration: initialDuration,
        ),
        _state = SlideCountdownState.notStarted {
    if (autoPlay && duration != null) {
      start();
    }
  }

  static Duration _calculateInitialValue({
    required bool countUp,
    Duration? duration,
    Duration? initialDuration,
  }) {
    if (countUp) {
      return initialDuration ?? Duration.zero;
    }
    return duration ?? Duration.zero;
  }

  /// The main countdown/countup duration.
  Duration _duration;

  /// Initial duration for count-up mode.
  final Duration? _initialDuration;

  /// Whether this is count up mode.
  final bool _isCountUp;

  /// Maximum duration for count-up mode.
  Duration? _maxDuration;

  /// The periodic interval for updates.
  final Duration periodic;

  /// Callback when countdown completes.
  final VoidCallback? onDone;

  /// Internal timer instance.
  PausableTimer? _timer;

  /// Current duration value.
  Duration _value;

  /// Current state of the controller.
  SlideCountdownState _state;

  /// Notifier for state changes.
  final ValueNotifier<SlideCountdownState> _stateNotifier =
      ValueNotifier(SlideCountdownState.notStarted);

  /// Returns a [ValueListenable] for the current state.
  ///
  // ignore: comment_references
  /// Use this with [ValueListenableBuilder] to react to state changes:
  /// ```dart
  /// ValueListenableBuilder<SlideCountdownState>(
  ///   valueListenable: controller.stateNotifier,
  ///   builder: (context, state, child) {
  ///     return Icon(state == SlideCountdownState.running
  ///         ? Icons.pause
  ///         : Icons.play_arrow);
  ///   },
  /// )
  /// ```
  ValueListenable<SlideCountdownState> get stateNotifier => _stateNotifier;

  /// Returns the current duration value.
  @override
  Duration get value => _value;

  /// Whether the controller is in count-up mode.
  bool get isCountUp => _isCountUp;

  /// Returns the current state of the countdown.
  SlideCountdownState get state => _state;

  /// Returns whether the timer is currently paused.
  bool get isPaused => _state == SlideCountdownState.paused;

  /// Returns whether the timer is currently running.
  bool get isRunning => _state == SlideCountdownState.running;

  /// Returns whether the timer has completed.
  bool get isCompleted => _state == SlideCountdownState.completed;

  /// Returns whether the timer has not started.
  bool get isNotStarted => _state == SlideCountdownState.notStarted;

  /// Returns whether the countdown is finished.
  bool get isFinished {
    if (!_isCountUp && _value.inSeconds <= 0) return true;

    return _isCountUp && _maxDuration != null && _value >= _maxDuration!;
  }

  /// The duration of the countdown.
  Duration get duration => _duration;

  void _setState(SlideCountdownState newState) {
    if (_state != newState) {
      _state = newState;
      _stateNotifier.value = newState;
    }
  }

  /// Starts the countdown timer.
  ///
  /// If the timer was previously stopped or has not been started yet,
  /// this will start it from the beginning.
  void start() {
    if (_state == SlideCountdownState.running) return;

    _timer?.cancel();
    _timer = PausableTimer.periodic(
      periodic,
      _onTick,
    );
    _timer?.start();
    _setState(SlideCountdownState.running);
    notifyListeners();
  }

  void _onTick() {
    if (_isCountUp) {
      _value += periodic;
    } else {
      _value -= periodic;
    }
    notifyListeners();
    if (isFinished) {
      _onDone();
    }
  }

  void _onDone() {
    _timer?.pause();
    _setState(SlideCountdownState.completed);
    onDone?.call();
    notifyListeners();
  }

  /// Pauses the countdown timer.
  ///
  /// The timer can be resumed using [resume].
  void pause() {
    if (_state != SlideCountdownState.running) return;

    _timer?.pause();
    _setState(SlideCountdownState.paused);
    notifyListeners();
  }

  /// Resumes the countdown timer after being paused or stopped.
  ///
  /// If the timer was stopped or has not started, this will start it.
  /// If the timer was paused, this will resume from where it left off.
  void resume() {
    if (_state == SlideCountdownState.running ||
        _state == SlideCountdownState.completed) {
      return;
    }

    if (_state == SlideCountdownState.notStarted) {
      start();
      return;
    }

    // State is paused
    _timer?.start();
    _setState(SlideCountdownState.running);
    notifyListeners();
  }

  /// Stops the countdown timer and resets to the initial duration.
  ///
  /// This is equivalent to calling [pause] followed by [reset].
  void stop() {
    _timer?.cancel();
    _timer = null;
    _reset();
    _setState(SlideCountdownState.notStarted);
    notifyListeners();
  }

  /// Resets the countdown timer to the initial duration.
  ///
  /// If the timer was running, it will continue running after reset.
  /// If the timer was paused, it will remain paused.
  void reset() {
    final wasRunning = _state == SlideCountdownState.running;
    _reset();

    if (wasRunning) {
      _setState(SlideCountdownState.running);
    } else if (_state == SlideCountdownState.completed) {
      _setState(SlideCountdownState.notStarted);
    }

    notifyListeners();
  }

  void _reset() {
    if (_isCountUp) {
      _value = _initialDuration ?? Duration.zero;
    } else {
      _value = _duration;
    }
  }

  /// Changes the countdown duration.
  ///
  /// This will also reset the current value to the new duration.
  /// If [shouldReset] is true (default), the timer value will be reset to
  /// the new duration. Otherwise, the timer will continue from its current
  /// value.
  void setDuration(Duration duration, {bool shouldReset = true}) {
    _duration = duration;
    if (shouldReset) {
      if (!_isCountUp) {
        _value = duration;
      }
      notifyListeners();
    }
  }

  /// Sets the maximum duration for count-up mode.
  // ignore: use_setters_to_change_properties
  void setMaxDuration(Duration? maxDuration) {
    _maxDuration = maxDuration;
  }

  /// Seeks to a specific duration value.
  ///
  /// This directly sets the current countdown value without affecting
  /// the timer state.
  void seekTo(Duration duration) {
    _value = duration;
    notifyListeners();
  }

  /// Adds time to the current countdown.
  void add(Duration duration) {
    _value += duration;
    notifyListeners();
  }

  /// Subtracts time from the current countdown.
  void subtract(Duration duration) {
    _value -= duration;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stateNotifier.dispose();
    super.dispose();
  }
}
