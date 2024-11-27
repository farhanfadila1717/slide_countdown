import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:slide_countdown/src/models/slide_countdown_base.dart';
import 'package:slide_countdown/src/utils/extensions.dart';
import 'package:slide_countdown/src/utils/utils.dart';
import 'package:slide_countdown/src/widgets/digit_item.dart';

/// {@template slide_countdown}
/// The SlideCountdownSeparated is a StatefulWidget that
/// creates a countdown timer that slides up or down to display
/// the remaining time and each duration will be separated.
///
/// Example usage:
///
/// ```dart
/// SlideCountdown(
///   duration: const Duration(days: 2),
/// );
/// ```
/// {@endtemplate}
class SlideCountdown extends SlideCountdownBase {
  /// {@macro slide_countdown}
  const SlideCountdown({
    super.key,
    super.duration,
    super.style = kDefaultTextStyle,
    super.separatorStyle = kDefaultTextStyle,
    super.icon,
    super.suffixIcon,
    super.separator,
    super.replacement,
    super.onDone,
    super.durationTitle,
    super.separatorType = SeparatorType.symbol,
    super.slideDirection = SlideDirection.down,
    super.padding = kDefaultPadding,
    super.separatorPadding = kDefaultSeparatorPadding,
    super.showZeroValue = false,
    super.decoration = kDefaultBoxDecoration,
    super.countUp = false,
    super.infinityCountUp = false,
    super.countUpAtDuration,
    super.digitsNumber,
    super.streamDuration,
    super.onChanged,
    super.shouldShowDays,
    super.shouldShowHours,
    super.shouldShowMinutes,
    super.shouldShowSeconds,
    super.slideAnimationDuration,
    super.slideAnimationCurve,
    super.shouldDispose = true,
  });

  @override
  State createState() => _SlideCountdownState();
}

class _SlideCountdownState extends State<SlideCountdown> {
  late final StreamDuration _streamDuration;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    _streamDurationListener();
  }

  @override
  void didUpdateWidget(covariant SlideCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.streamDuration == null &&
        widget.duration != oldWidget.duration) {
      _streamDuration.seek(widget.duration!);
    }
  }

  void _streamDurationListener() {
    _streamDuration = widget.streamDuration ??
        StreamDuration(
          config: StreamDurationConfig(
            isCountUp: widget.countUp,
            onDone: () {
              if (!isDisposed && mounted) {
                widget.onDone?.call();
              }
            },
            countDownConfig: CountDownConfig(
              duration: widget.duration!,
            ),
            countUpConfig: CountUpConfig(
              initialDuration:
                  widget.countUpAtDuration != null && widget.countUpAtDuration!
                      ? widget.duration!
                      : Duration.zero,
              maxDuration: widget.infinityCountUp ? null : widget.duration,
            ),
          ),
        );

    if (widget.onChanged != null) {
      _streamDuration.addListener(() {
        if (!isDisposed && mounted) {
          widget.onChanged?.call(_streamDuration.value);
        }
      });
    }
  }

  @override
  void dispose() {
    isDisposed = true; // Mark the widget as disposed.
    if (widget.shouldDispose) {
      _streamDuration.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final durationTitle = widget.durationTitle ?? DurationTitle.en();
    final textDirection = Directionality.of(context);
    final separator = widget.separator ?? ':';

    final leadingIcon = Visibility(
      visible: widget.icon != null,
      child: widget.icon ?? const SizedBox.shrink(),
    );

    final suffixIcon = Visibility(
      visible: widget.suffixIcon != null,
      child: widget.suffixIcon ?? const SizedBox.shrink(),
    );

    return RawSlideCountdown(
      streamDuration: _streamDuration,
      builder: (_, duration) {
        if (duration.inSeconds <= 0 && widget.replacement != null) {
          return widget.replacement!;
        }

        final defaultShowDays = !(duration.inDays < 1 && !widget.showZeroValue);
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

        final days = DigitItem(
          duration: duration,
          timeUnit: TimeUnit.days,
          padding: widget.padding,
          decoration: widget.decoration,
          separatorStyle: widget.separatorStyle,
          style: widget.style,
          slideDirection: widget.slideDirection,
          countUp: widget.countUp,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.days
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator: (showHours || showMinutes || showSeconds) ||
              (isSeparatorTitle && showDays),
          slideAnimationDuration: widget.slideAnimationDuration,
          slideAnimationCurve: widget.slideAnimationCurve,
        );

        final hours = DigitItem(
          duration: duration,
          timeUnit: TimeUnit.hours,
          padding: widget.padding,
          decoration: widget.decoration,
          style: widget.style,
          separatorStyle: widget.separatorStyle,
          slideDirection: widget.slideDirection,
          countUp: widget.countUp,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.hours
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator:
              showMinutes || showSeconds || (isSeparatorTitle && showHours),
          slideAnimationDuration: widget.slideAnimationDuration,
          slideAnimationCurve: widget.slideAnimationCurve,
        );

        final minutes = DigitItem(
          duration: duration,
          timeUnit: TimeUnit.minutes,
          padding: widget.padding,
          decoration: widget.decoration,
          style: widget.style,
          separatorStyle: widget.separatorStyle,
          slideDirection: widget.slideDirection,
          countUp: widget.countUp,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.minutes
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator: showSeconds || (isSeparatorTitle && showMinutes),
          slideAnimationDuration: widget.slideAnimationDuration,
          slideAnimationCurve: widget.slideAnimationCurve,
        );

        final seconds = DigitItem(
          duration: duration,
          timeUnit: TimeUnit.seconds,
          padding: widget.padding,
          decoration: widget.decoration,
          style: widget.style,
          separatorStyle: widget.separatorStyle,
          slideDirection: widget.slideDirection,
          countUp: widget.countUp,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.seconds
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator: isSeparatorTitle && showSeconds,
          slideAnimationDuration: widget.slideAnimationDuration,
          slideAnimationCurve: widget.slideAnimationCurve,
        );

        final daysWidget = showDays ? days : const SizedBox.shrink();
        final hoursWidget = showHours ? hours : const SizedBox.shrink();
        final minutesWidget = showMinutes ? minutes : const SizedBox.shrink();
        final secondsWidget = showSeconds ? seconds : const SizedBox.shrink();

        final countdown = Padding(
          padding: widget.padding,
          child: Row(
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
          ),
        );

        return Semantics(
          label: '$duration'.replaceAll('.000000', ''),
          container: true,
          child: DecoratedBox(
            decoration: widget.decoration,
            child: countdown,
          ),
        );
      },
    );
  }
}
