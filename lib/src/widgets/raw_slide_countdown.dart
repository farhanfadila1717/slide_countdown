import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

/// {@template raw_slide_countdown_builder}
/// Signature for a function that builds a widget for a raw slide countdown.
///
/// The [context] parameter is the [BuildContext] for the widget being built.
///
/// The [duration] parameter is the remaining duration for the countdown.
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
);

/// {@template raw_slide_countdown}
/// A widget that displays a countdown based on a [SlideCountdownController]
/// or [StreamDuration].
///
/// The [RawSlideCountdown] widget listens to the controller or streamDuration
/// and updates its display based on the received duration values.
///
/// The [builder] function is used to build the widget based on the current
/// [BuildContext] and the remaining [Duration] received from the stream.
///
/// Example with controller:
///
/// ```dart
/// final controller = SlideCountdownController(
///   duration: const Duration(minutes: 5),
/// );
///
/// RawSlideCountdown(
///   controller: controller,
///   builder: (BuildContext context, Duration remainingDuration) {
///     return RawDigitItem(
///         duration: remainingDuration,
///         timeUnit: TimeUnit.seconds,
///         digitType: DigitType.second,
///         countUp: controller.isCountUp,
///     );
///   },
/// )
/// ```
///
/// See also:
///
/// - [SlideCountdownController], which provides the countdown duration and
///   control methods.
/// - [RawSlideCountdownBuilder], a function signature for the builder used
///   to create the countdown widget.
/// {@endtemplate}
class RawSlideCountdown extends StatelessWidget {
  /// {@macro raw_slide_countdown}
  const RawSlideCountdown({
    required this.builder,
    this.controller,
    @Deprecated('Use controller instead') this.streamDuration,
    super.key,
  }) : assert(
          controller != null || streamDuration != null,
          'Either controller or streamDuration must be provided',
        );

  /// The [SlideCountdownController] that provides the countdown duration.
  final SlideCountdownController? controller;

  /// The [StreamDuration] that provides the countdown duration.
  @Deprecated('Use controller instead')
  final StreamDuration? streamDuration;

  /// The builder function used to create the countdown widget.
  /// {@macro raw_slide_countdown_builder}
  final RawSlideCountdownBuilder builder;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use_from_same_package, omit_local_variable_types
    final ValueListenable<Duration> listenable =
        // ignore: deprecated_member_use_from_same_package
        (controller as ValueListenable<Duration>?) ?? streamDuration!;

    return RepaintBoundary(
      child: ValueListenableBuilder<Duration>(
        valueListenable: listenable,
        builder: (_, duration, __) => builder(context, duration),
      ),
    );
  }
}
