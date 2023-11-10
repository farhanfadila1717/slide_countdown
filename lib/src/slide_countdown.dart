import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';

import 'utils/utils.dart';
import 'models/duration_title.dart';
import 'utils/enum.dart';
import 'utils/extensions.dart';
import 'models/slide_countdown_base.dart';
import 'widgets/digit_item.dart';
import 'widgets/raw_slide_countdown.dart';

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
    super.textStyle = kDefaultTextStyle,
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
    super.curve = Curves.easeOut,
    super.countUp = false,
    super.infinityCountUp = false,
    super.countUpAtDuration,
    super.slideAnimationDuration = kDefaultAnimationDuration,
    super.digitsNumber,
    super.streamDuration,
    super.onChanged,
    super.shouldShowDays,
    super.shouldShowHours,
    super.shouldShowMinutes,
    super.shouldShowSeconds,
  });

  @override
  _SlideCountdownState createState() => _SlideCountdownState();
}

class _SlideCountdownState extends State<SlideCountdown> {
  late StreamDuration _streamDuration;

  @override
  void initState() {
    super.initState();
    _streamDurationListener();
  }

  void _streamDurationListener() {
    _streamDuration = widget.streamDuration ??
        StreamDuration(
          config: StreamDurationConfig(
            autoPlay: true,
            isCountUp: widget.countUp,
            onDone: widget.onDone,
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
      _streamDuration.durationLeft.listen(
        (event) => widget.onChanged?.call(event),
      );
    }
  }

  @override
  void dispose() {
    _streamDuration.dispose();
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
      builder: (BuildContext context, Duration duration) {
        if (duration.inSeconds <= 0 && widget.replacement != null)
          return widget.replacement!;

        final defaultShowDays =
            duration.inDays < 1 && !widget.showZeroValue ? false : true;
        final defaultShowHours =
            duration.inHours < 1 && !widget.showZeroValue ? false : true;
        final defaultShowMinutes =
            duration.inMinutes < 1 && !widget.showZeroValue ? false : true;
        final defaultShowSeconds =
            duration.inSeconds < 1 && !widget.showZeroValue ? false : true;

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
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.days
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator: (showHours || showMinutes || showSeconds) ||
              (isSeparatorTitle && showDays),
        );

        final hours = DigitItem(
          duration: duration,
          timeUnit: TimeUnit.hours,
          padding: widget.padding,
          decoration: widget.decoration,
          style: widget.style,
          separatorStyle: widget.separatorStyle,
          slideDirection: widget.slideDirection,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.hours
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator:
              showMinutes || showSeconds || (isSeparatorTitle && showHours),
        );

        final minutes = DigitItem(
          duration: duration,
          timeUnit: TimeUnit.minutes,
          padding: widget.padding,
          decoration: widget.decoration,
          style: widget.style,
          separatorStyle: widget.separatorStyle,
          slideDirection: widget.slideDirection,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.minutes
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator: showSeconds || (isSeparatorTitle && showMinutes),
        );

        final seconds = DigitItem(
          duration: duration,
          timeUnit: TimeUnit.seconds,
          padding: widget.padding,
          decoration: widget.decoration,
          style: widget.style,
          separatorStyle: widget.separatorStyle,
          slideDirection: widget.slideDirection,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.seconds
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator: isSeparatorTitle && showSeconds,
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
        return DecoratedBox(
          decoration: widget.decoration,
          child: countdown,
        );
      },
    );
  }
}
