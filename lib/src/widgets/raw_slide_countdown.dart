import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

/// {@template raw_slide_countdown_builder}
/// Signature for a function that builds a widget for a raw slide countdown.
///
/// The [context] parameter is the [BuildContext] for the widget being built.
///
/// The [duration] parameter is the remaining duration for the countdown.
///
/// The [isCountUp] parameter is to know remaining duration is countdown or countup.
///
/// The function should return a [Widget] that represents the current state of
/// the countdown.
///
/// This typedef is typically used in conjunction with raw slide countdown
/// widgets to customize the appearance and behavior of the countdown display.
/// {@endtemplate}
typedef RawSlideCountdownBuilder = Widget Function(
  BuildContext context,
  Duration duration,
  bool isCountUp,
);

/// {@template raw_slide_countdown}
/// A widget that displays a countdown based on a [StreamDuration].
///
/// The [RawSlideCountdown] widget listens to the [streamDuration.durationLeft]
/// stream and updates its display based on the received duration values.
///
/// The [builder] function is used to build the widget based on the current
/// [BuildContext] and the remaining [Duration] received from the stream.
///
/// Example:
///
/// ```dart
/// RawSlideCountdown(
///   streamDuration: myStreamDuration,
///   builder: (BuildContext context, Duration remainingDuration) {
///     return RawDigitItem(
///         duration: remainingDuration,
///         timeUnit: TimeUnit.seconds,
///         digitType: DigitType.second,
///         countUp: false,
///     );
///   },
/// )
/// ```
///
/// In the above example, the `RawSlideCountdown` widget listens to the
/// `myStreamDuration.durationLeft` stream and updates the displayed text
/// based on the remaining duration.
///
/// See also:
///
/// - [StreamDuration], which represents a stream of countdown durations.
/// - [RawSlideCountdownBuilder], a function signature for the builder used
///   to create the countdown widget.
/// {@endtemplate}
class RawSlideCountdown extends StatefulWidget {
  /// {@macro raw_slide_countdown}
  const RawSlideCountdown({
    super.key,
    required this.streamDuration,
    required this.builder,
  });

  /// The [StreamDuration] that provides the countdown duration.
  final StreamDuration streamDuration;

  /// The builder function used to create the countdown widget.
  /// {@macro raw_slide_countdown_builder}
  final RawSlideCountdownBuilder builder;

  @override
  State<RawSlideCountdown> createState() => _RawSlideCountdownState();
}

class _RawSlideCountdownState extends State<RawSlideCountdown> {
  late final ValueNotifier<Duration> _durationNotifier;

  @override
  void initState() {
    super.initState();
    listenDuration();
  }

  void listenDuration() {
    _durationNotifier = ValueNotifier(
      widget.streamDuration.remainingDuration,
    );

    widget.streamDuration.durationLeft.listen(
      (duration) {
        if (mounted) _durationNotifier.value = duration;
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    _durationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ValueListenableBuilder(
        valueListenable: _durationNotifier,
        builder: (_, duration, __) => widget.builder(
          context,
          duration,
          widget.streamDuration.isCountUp,
        ),
      ),
    );
  }
}
