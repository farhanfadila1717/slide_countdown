import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:slide_countdown/src/models/slide_countdown_base.dart';
import 'package:slide_countdown/src/utils/extensions.dart';
import 'package:slide_countdown/src/utils/utils.dart';
import 'package:slide_countdown/src/widgets/digit_separated_item.dart';

/// {@template slide_countdown_separated}
/// The SlideCountdownSeparated is a StatefulWidget that
/// creates a countdown timer that slides up or down to display
/// the remaining time and each duration will be separated.
///
/// Example usage:
///
/// ```dart
/// SlideCountdownSeparated(
///   duration: const Duration(days: 2),
/// );
/// ```
///
/// With controller:
///
/// ```dart
/// final controller = SlideCountdownController();
///
/// SlideCountdownSeparated(
///   controller: controller,
///   duration: const Duration(days: 2),
/// );
///
/// // Control the countdown
/// controller.start();
/// controller.pause();
/// controller.reset();
/// ```
/// {@endtemplate}
class SlideCountdownSeparated extends SlideCountdownBase {
  /// {@macro slide_countdown_separated}
  const SlideCountdownSeparated({
    super.key,
    super.duration,
    super.style = kDefaultTextStyle,
    super.separatorStyle = kDefaultSeparatorTextStyle,
    super.icon,
    super.suffixIcon,
    super.separator,
    super.replacement,
    super.onDone,
    super.durationTitle,
    super.separatorType = SeparatorType.symbol,
    super.slideDirection = SlideDirection.down,
    super.padding = const EdgeInsets.all(5),
    super.separatorPadding = const EdgeInsets.symmetric(horizontal: 3),
    super.showZeroValue = false,
    super.decoration = kDefaultSeparatedBoxDecoration,
    super.countUp = false,
    super.infinityCountUp = false,
    super.countUpAtDuration,
    super.digitsNumber,
    @Deprecated('Use controller instead') super.streamDuration,
    super.controller,
    super.onChanged,
    super.shouldShowDays,
    super.shouldShowHours,
    super.shouldShowMinutes,
    super.shouldShowSeconds,
    super.slideAnimationDuration,
    super.slideAnimationCurve,
    super.separatorPosition = SeparatorPosition.middle,
    super.shouldDispose = true,
  });

  @override
  State createState() => _SlideCountdownSeparatedState();
}

class _SlideCountdownSeparatedState extends State<SlideCountdownSeparated> {
  late final ValueListenable<Duration> _durationNotifier;
  bool _isInternalController = false;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initDurationNotifier();
  }

  @override
  void didUpdateWidget(covariant SlideCountdownSeparated oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ignore: deprecated_member_use_from_same_package
    if (widget.controller == null && widget.streamDuration == null) {
      if (widget.duration != oldWidget.duration) {
        if (_durationNotifier is SlideCountdownController) {
          (_durationNotifier as SlideCountdownController)
              .setDuration(widget.duration!);
        } else if (_durationNotifier is StreamDuration) {
          (_durationNotifier as StreamDuration).seek(widget.duration!);
        }
      }
    }
  }

  void _initDurationNotifier() {
    // Priority: controller > streamDuration > internal controller
    if (widget.controller != null) {
      _durationNotifier = widget.controller!;
      _isInternalController = false;
      // ignore: deprecated_member_use_from_same_package
    } else if (widget.streamDuration != null) {
      // ignore: deprecated_member_use_from_same_package
      _durationNotifier = widget.streamDuration!;
      _isInternalController = false;
    } else {
      // Create internal controller
      final controller = SlideCountdownController(
        duration: widget.duration!,
        countUp: widget.countUp,
        maxDuration: widget.infinityCountUp ? null : widget.duration,
        initialDuration:
            (widget.countUpAtDuration ?? false) ? widget.duration : null,
        onDone: () {
          if (!isDisposed && mounted) {
            widget.onDone?.call();
          }
        },
      );
      _durationNotifier = controller;
      _isInternalController = true;
    }

    if (widget.onChanged != null) {
      _durationNotifier.addListener(_onDurationChanged);
    }
  }

  void _onDurationChanged() {
    if (!isDisposed && mounted) {
      widget.onChanged?.call(_durationNotifier.value);
    }
  }

  bool get _isCountUp {
    if (widget.controller != null) {
      return widget.controller!.isCountUp;
    }
    // ignore: deprecated_member_use_from_same_package
    if (widget.streamDuration != null) {
      // ignore: deprecated_member_use_from_same_package
      return widget.streamDuration!.isCountUp;
    }
    return widget.countUp;
  }

  @override
  void dispose() {
    isDisposed = true;
    if (widget.shouldDispose && _isInternalController) {
      if (_durationNotifier is SlideCountdownController) {
        (_durationNotifier as SlideCountdownController).dispose();
      } else if (_durationNotifier is StreamDuration) {
        (_durationNotifier as StreamDuration).dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final durationTitle = widget.durationTitle ?? DurationTitle.en();
    final separator = widget.separator ?? ':';
    final textDirection = Directionality.of(context);

    final leadingIcon = Visibility(
      visible: widget.icon != null,
      child: widget.icon ?? const SizedBox.shrink(),
    );

    final suffixIcon = Visibility(
      visible: widget.suffixIcon != null,
      child: widget.suffixIcon ?? const SizedBox.shrink(),
    );

    return RepaintBoundary(
      child: ValueListenableBuilder<Duration>(
        valueListenable: _durationNotifier,
        builder: (context, duration, __) {
          if (duration.inSeconds <= 0 && widget.replacement != null) {
            return widget.replacement!;
          }

          final defaultShowDays =
              !(duration.inDays < 1 && !widget.showZeroValue);
          final defaultShowHours =
              !(duration.inHours < 1 && !widget.showZeroValue);
          final defaultShowMinutes =
              !(duration.inMinutes < 1 && !widget.showZeroValue);
          final defaultShowSeconds =
              !(duration.inSeconds < 1 && !widget.showZeroValue);

          final showDays = widget.shouldShowDays != null
              ? widget.shouldShowDays!(duration)
              : defaultShowDays;
          final showHours = widget.shouldShowHours != null
              ? widget.shouldShowHours!(duration)
              : defaultShowHours;
          final showMinutes = widget.shouldShowMinutes != null
              ? widget.shouldShowMinutes!(duration)
              : defaultShowMinutes;
          final showSeconds = widget.shouldShowSeconds != null
              ? widget.shouldShowSeconds!(duration)
              : defaultShowSeconds;

          final isSeparatorTitle = widget.separatorType == SeparatorType.title;

          final days = DigitSeparatedItem(
            duration: duration,
            timeUnit: TimeUnit.days,
            padding: widget.padding,
            decoration: widget.decoration,
            style: widget.style,
            separatorStyle: widget.separatorStyle,
            slideDirection: widget.slideDirection,
            countUp: _isCountUp,
            separatorPadding: widget.separatorPadding,
            separator: widget.separatorType == SeparatorType.title
                ? durationTitle.days
                : separator,
            textDirection: textDirection,
            digitsNumber: widget.digitsNumber,
            showSeparator: (showHours || showMinutes || showSeconds) ||
                (isSeparatorTitle && showDays),
            slideAnimationDuration: widget.slideAnimationDuration,
            slideAnimationCurve: widget.slideAnimationCurve,
            separatorPosition: widget.separatorPosition,
          );

          final hours = DigitSeparatedItem(
            duration: duration,
            timeUnit: TimeUnit.hours,
            padding: widget.padding,
            decoration: widget.decoration,
            style: widget.style,
            separatorStyle: widget.separatorStyle,
            slideDirection: widget.slideDirection,
            countUp: _isCountUp,
            separatorPadding: widget.separatorPadding,
            separator: widget.separatorType == SeparatorType.title
                ? durationTitle.hours
                : separator,
            textDirection: textDirection,
            digitsNumber: widget.digitsNumber,
            showSeparator:
                showMinutes || showSeconds || (isSeparatorTitle && showHours),
            slideAnimationDuration: widget.slideAnimationDuration,
            slideAnimationCurve: widget.slideAnimationCurve,
            separatorPosition: widget.separatorPosition,
          );

          final minutes = DigitSeparatedItem(
            duration: duration,
            timeUnit: TimeUnit.minutes,
            padding: widget.padding,
            decoration: widget.decoration,
            style: widget.style,
            separatorStyle: widget.separatorStyle,
            slideDirection: widget.slideDirection,
            countUp: _isCountUp,
            separatorPadding: widget.separatorPadding,
            separator: widget.separatorType == SeparatorType.title
                ? durationTitle.minutes
                : separator,
            textDirection: textDirection,
            digitsNumber: widget.digitsNumber,
            showSeparator: showSeconds || (isSeparatorTitle && showMinutes),
            slideAnimationDuration: widget.slideAnimationDuration,
            slideAnimationCurve: widget.slideAnimationCurve,
            separatorPosition: widget.separatorPosition,
          );

          final seconds = DigitSeparatedItem(
            duration: duration,
            timeUnit: TimeUnit.seconds,
            padding: widget.padding,
            decoration: widget.decoration,
            style: widget.style,
            separatorStyle: widget.separatorStyle,
            slideDirection: widget.slideDirection,
            countUp: _isCountUp,
            separatorPadding: widget.separatorPadding,
            separator: widget.separatorType == SeparatorType.title
                ? durationTitle.seconds
                : separator,
            textDirection: textDirection,
            digitsNumber: widget.digitsNumber,
            showSeparator: isSeparatorTitle && showSeconds,
            slideAnimationDuration: widget.slideAnimationDuration,
            slideAnimationCurve: widget.slideAnimationCurve,
            separatorPosition: widget.separatorPosition,
          );

          final daysWidget = showDays ? days : const SizedBox.shrink();

          final hoursWidget = showHours ? hours : const SizedBox.shrink();

          final minutesWidget = showMinutes ? minutes : const SizedBox.shrink();

          final secondsWidget = showSeconds ? seconds : const SizedBox.shrink();

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: textDirection.isRtl
                ? [
                    suffixIcon,
                    secondsWidget,
                    minutesWidget,
                    hoursWidget,
                    daysWidget,
                    leadingIcon,
                  ]
                : [
                    leadingIcon,
                    daysWidget,
                    hoursWidget,
                    minutesWidget,
                    secondsWidget,
                    suffixIcon,
                  ],
          );
        },
      ),
    );
  }
}
