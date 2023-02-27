import 'package:flutter/material.dart';
import 'package:slide_countdown/src/utils/utils.dart';
import 'package:stream_duration/stream_duration.dart';
import 'separated/separated.dart';

import 'utils/countdown_mixin.dart';
import 'utils/duration_title.dart';
import 'utils/enum.dart';
import 'utils/extensions.dart';
import 'utils/notifiy_duration.dart';
import 'utils/text_animation.dart';

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
/// {@endtemplate}
class SlideCountdownSeparated extends StatefulWidget {
  /// {@macro slide_countdown_separated}
  const SlideCountdownSeparated({
    super.key,
    this.duration,
    this.height = 30,
    this.width = 30,
    this.textStyle =
        const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
    this.separatorStyle =
        const TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold),
    this.icon,
    this.suffixIcon,
    this.separator,
    this.replacement,
    this.onDone,
    this.durationTitle,
    this.separatorType = SeparatorType.symbol,
    this.slideDirection = SlideDirection.down,
    this.padding = const EdgeInsets.all(5),
    this.separatorPadding = const EdgeInsets.symmetric(horizontal: 3),
    this.showZeroValue = false,
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      color: Color(0xFFF23333),
    ),
    this.curve = Curves.easeOut,
    this.countUp = false,
    this.countUpAtDuration = false,
    this.infinityCountUp = false,
    this.slideAnimationDuration = const Duration(milliseconds: 300),
    this.textDirection = TextDirection.rtl,
    this.digitsNumber,
    this.streamDuration,
    this.onChanged,
    this.shouldShowDays,
    this.shouldShowHours,
    this.shouldShowMinutes,
    this.shouldShowSeconds,
    this.autoPlay = true,
    this.countInvisible = true,
  }) : assert(
          duration != null || streamDuration != null,
          'Either duration or streamDuration has to be provided',
        );

  /// [Duration] is the duration of the countdown slide,
  /// if the duration has finished it will call [onDone]
  final Duration? duration;

  /// height to set the size of height each [Container]
  /// [Container] will be the background of each a duration
  /// to decorate the [Container] on the [decoration] property
  final double height;

  /// width to set the size of width each [Container]
  /// [Container] will be the background of each a duration
  /// to decorate the [Container] on the [decoration] property
  final double width;

  /// [TextStyle] is a parameter for all existing text,
  /// if this is null [SlideCountdownSeparated] has a default
  /// text style which will be of all text
  final TextStyle textStyle;

  /// [TextStyle] is a parameter for all existing text,
  /// if this is null [SlideCountdownSeparated] has a default
  /// text style which will be of all text
  final TextStyle separatorStyle;

  /// [icon] is a parameter that can be initialized by any widget e.g [Icon],
  /// this will be in the first order, default empty widget
  final Widget? icon;

  /// [icon] is a parameter that can be initialized by any widget e.g [Icon],
  /// this will be in the end order, default empty widget
  final Widget? suffixIcon;

  /// Separator is a parameter that will separate each [duration],
  /// e.g hours by minutes, and you can change the [SeparatorType] of the symbol or title
  final String? separator;

  /// A widget that will be displayed to replace
  /// the countdown when the remaining [duration] has finished
  /// if null  default widget is [SizedBox].
  final Widget? replacement;

  /// function [onDone] will be called when countdown is complete
  final VoidCallback? onDone;

  /// {$macro separator_type}
  final SeparatorType separatorType;

  /// change [Duration Title] if you want to change the default language,
  /// which is English, to another language, for example, into Indonesian
  /// pro tips: if you change to Indonesian, we have default values [DurationTitle.id()]
  final DurationTitle? durationTitle;

  /// The decoration to paint in front of the [child].
  final Decoration decoration;

  /// The amount of space by which to inset the child.
  final EdgeInsets padding;

  /// The amount of space by which to inset the [separator].
  final EdgeInsets separatorPadding;

  /// if you initialize it with false, the duration which is empty will not be displayed
  final bool showZeroValue;

  /// {@macro slide_direction}
  final SlideDirection slideDirection;

  /// to customize curve in [TextAnimation] you can change the default value
  /// default [Curves.easeOut]
  final Curve curve;

  ///this property allows you to do a count up, give it a value of true to do it
  final bool countUp;

  ///this property allows you to count up at the duration you set
  final bool countUpAtDuration;

  /// if you set this property value to true, it will do the count up continuously or infinity
  /// and the [onDone] property will never be executed,
  /// before doing that you need to set true to the [countUp] property,
  final bool infinityCountUp;

  /// SlideAnimationDuration which will be the duration of the slide animation from above or below
  final Duration slideAnimationDuration;

  /// Text direction for change row positions of each item
  /// ltr => [01] : [02] : [03]
  /// rtl => [03] : [02] : [01]
  final TextDirection textDirection;

  /// {@macro override_digits}
  final OverrideDigits? digitsNumber;

  /// If you ovveride [StreamDuration] package for stream a duration
  /// property [duration], [countUp], [infinityCountUp], and [onDone] in [SlideCountdownSeparated] not affected
  /// Example you need use function in [StreamDuration]
  /// e.g correct, add, and subtract function
  final StreamDuration? streamDuration;

  /// if you need to stream the remaining available duration,
  /// it will be called every time the duration changes.
  final ValueChanged<Duration>? onChanged;

  /// This will trigger the days item will show or hide from the return value
  /// You can also show or hide based on the remaining duration
  /// e.g shouldShowDays: (`Duration` remainingDuration) => remainingDuration.inDays >= 1
  /// if null and [showZeroValue] is false
  /// when duration in days is zero it will return false
  final ShouldShowItems? shouldShowDays;

  /// This will trigger the hours item will show or hide from the return value
  /// You can also show or hide based on the remaining duration
  /// e.g shouldShowHours: () => remainingDuration.inHours >= 1
  /// if null and [showZeroValue] is false
  /// when duration in hours is zero it will return false
  final ShouldShowItems? shouldShowHours;

  /// This will trigger the minutes item will show or hide from the return value
  /// You can also show or hide based on the remaining duration
  /// e.g shouldShowMinutes: () => remainingDuration.inMinutes >= 1
  /// if null and [showZeroValue] is false
  /// when duration in minutes is zero it will return false
  final ShouldShowItems? shouldShowMinutes;

  /// This will trigger the minutes item will show or hide from the return value
  /// You can also show or hide based on the remaining duration
  /// e.g shouldShowSeconds: () => remainingDuration.inSeconds >= 1
  /// if null and [showZeroValue] is false
  /// when duration in seconds is zero it will return false
  final ShouldShowItems? shouldShowSeconds;

  /// if you set this property value to true, it will count all the parents that invisible;
  /// e.g 1 H 11 m . Then set 'shouldShowHours'  false will show 71 m
  /// when 'countInvisible' is true and show 11 m when it is false
  /// default is true
  final bool? countInvisible;

  final bool autoPlay;

  @override
  _SlideCountdownSeparatedState createState() =>
      _SlideCountdownSeparatedState();
}

class _SlideCountdownSeparatedState extends State<SlideCountdownSeparated>
    with CountdownMixin {
  late StreamDuration _streamDuration;
  late NotifiyDuration _notifiyDuration;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _notifiyDuration = NotifiyDuration(duration);
    _disposed = false;
    _streamDurationListener();
    _updateConfigurationNotifier(widget.duration);
  }

  @override
  void didUpdateWidget(covariant SlideCountdownSeparated oldWidget) {
    if (widget.countUp != oldWidget.countUp ||
        widget.infinityCountUp != oldWidget.infinityCountUp) {
      _streamDurationListener();
    }
    if (widget.duration != oldWidget.duration && widget.duration != null) {
      _streamDuration.change(widget.duration!);
    }

    if (oldWidget.shouldShowDays != widget.shouldShowDays ||
        oldWidget.shouldShowHours != widget.shouldShowHours ||
        oldWidget.shouldShowMinutes != widget.shouldShowMinutes ||
        oldWidget.shouldShowSeconds != widget.shouldShowSeconds ||
        oldWidget.showZeroValue != widget.showZeroValue) {
      _updateConfigurationNotifier();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _streamDurationListener() {
    _streamDuration = StreamDuration(
      duration,
      autoPlay: widget.autoPlay,
      countUpAtDuration: widget.countUpAtDuration,
      onDone: () {
        if (widget.onDone != null) {
          widget.onDone!();
        }
      },
      countUp: widget.countUp,
      infinity: widget.infinityCountUp,
    );

    if (!_disposed) {
      try {
        _streamDuration.durationLeft.listen((duration) {
          _notifiyDuration.streamDuration(duration);
          updateValue(duration);
          if (widget.onChanged != null) {
            widget.onChanged!(duration);
          }
        });
      } catch (ex) {
        debugPrint(ex.toString());
      }
    }
  }

  void _updateConfigurationNotifier([Duration? duration]) {
    final remainingDuration = duration ?? _streamDuration.remainingDuration;
    final defaultShowDays =
        remainingDuration.inDays < 1 && !widget.showZeroValue ? false : true;
    final defaultShowHours =
        remainingDuration.inHours < 1 && !widget.showZeroValue ? false : true;
    final defaultShowMinutes =
        remainingDuration.inMinutes < 1 && !widget.showZeroValue ? false : true;
    final defaultShowSeconds =
        remainingDuration.inSeconds < 1 && !widget.showZeroValue ? false : true;

    /// cal func from CountdownMixin
    updateConfigurationNotifier(
      updateDaysNotifier: widget.shouldShowDays != null
          ? widget.shouldShowDays!(remainingDuration)
          : defaultShowDays,
      updateHoursNotifier: widget.shouldShowHours != null
          ? widget.shouldShowHours!(remainingDuration)
          : defaultShowHours,
      updateMinutesNotifier: widget.shouldShowMinutes != null
          ? widget.shouldShowMinutes!(remainingDuration)
          : defaultShowMinutes,
      updateSecondsNotifier: widget.shouldShowSeconds != null
          ? widget.shouldShowSeconds!(remainingDuration)
          : defaultShowSeconds,
        countInvisible:widget.countInvisible
    );
  }

  Duration get duration => widget.duration ?? widget.streamDuration!.duration;

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    _streamDuration.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final durationTitle = widget.durationTitle ?? DurationTitle.en();
    final separator = widget.separator ?? ':';

    final leadingIcon = Visibility(
      visible: widget.icon != null,
      child: widget.icon ?? const SizedBox.shrink(),
    );

    final suffixIcon = Visibility(
      visible: widget.suffixIcon != null,
      child: widget.suffixIcon ?? const SizedBox.shrink(),
    );

    return ValueListenableBuilder(
      valueListenable: _notifiyDuration,
      builder: (BuildContext context, Duration duration, Widget? child) {
        if (duration.inSeconds <= 0 && child != null) return child;

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

        final days = DigitSeparatedItem(
          height: widget.height,
          width: widget.width,
          decoration: widget.decoration,
          firstDigit: daysFirstDigitNotifier,
          secondDigit: daysSecondDigitNotifier,
          textStyle: widget.textStyle,
          separatorStyle: widget.separatorStyle,
          initValue: 0,
          slideDirection: widget.slideDirection,
          showZeroValue: widget.showZeroValue,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separatorPadding: widget.separatorPadding,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.days
              : separator,
          textDirection: widget.textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator: (showHours || showMinutes || showSeconds) ||
              (isSeparatorTitle && showDays),
        );

        final hours = DigitSeparatedItem(
          height: widget.height,
          width: widget.width,
          decoration: widget.decoration,
          firstDigit: hoursFirstDigitNotifier,
          secondDigit: hoursSecondDigitNotifier,
          textStyle: widget.textStyle,
          separatorStyle: widget.separatorStyle,
          initValue: 0,
          slideDirection: widget.slideDirection,
          showZeroValue: widget.showZeroValue,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separatorPadding: widget.separatorPadding,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.hours
              : separator,
          textDirection: widget.textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator:
              showMinutes || showSeconds || (isSeparatorTitle && showHours),
        );

        final minutes = DigitSeparatedItem(
          height: widget.height,
          width: widget.width,
          decoration: widget.decoration,
          firstDigit: minutesFirstDigitNotifier,
          secondDigit: minutesSecondDigitNotifier,
          textStyle: widget.textStyle,
          separatorStyle: widget.separatorStyle,
          initValue: 0,
          slideDirection: widget.slideDirection,
          showZeroValue: widget.showZeroValue,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separatorPadding: widget.separatorPadding,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.minutes
              : separator,
          textDirection: widget.textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator: showSeconds || (isSeparatorTitle && showMinutes),
        );

        final seconds = DigitSeparatedItem(
          height: widget.height,
          width: widget.width,
          decoration: widget.decoration,
          firstDigit: secondsFirstDigitNotifier,
          secondDigit: secondsSecondDigitNotifier,
          textStyle: widget.textStyle,
          separatorStyle: widget.separatorStyle,
          initValue: 0,
          slideDirection: widget.slideDirection,
          showZeroValue: widget.showZeroValue,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separatorPadding: widget.separatorPadding,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.seconds
              : separator,
          textDirection: widget.textDirection,
          digitsNumber: widget.digitsNumber,
          showSeparator: isSeparatorTitle && showSeconds,
        );

        final daysWidget = showDays ? days : const SizedBox.shrink();

        final hoursWidget = showHours ? hours : const SizedBox.shrink();

        final minutesWidget = showMinutes ? minutes : const SizedBox.shrink();

        final secondsWidget = showSeconds ? seconds : const SizedBox.shrink();

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.textDirection.isRtl
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
      child: widget.replacement,
    );
  }
}
