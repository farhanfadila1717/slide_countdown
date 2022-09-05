import 'package:flutter/material.dart';
import 'package:slide_countdown/src/utils/utils.dart';
import 'package:stream_duration/stream_duration.dart';

import 'default/default.dart';
import 'utils/countdown_mixin.dart';
import 'utils/duration_title.dart';
import 'utils/enum.dart';
import 'utils/extensions.dart';
import 'utils/notifiy_duration.dart';

class SlideCountdown extends StatefulWidget {
  const SlideCountdown({
    Key? key,
    required this.duration,
    this.textStyle =
        const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
    this.separatorStyle,
    this.icon,
    this.suffixIcon,
    this.separator,
    this.replacement,
    this.onDone,
    this.durationTitle,
    this.separatorType = SeparatorType.symbol,
    this.slideDirection = SlideDirection.down,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.separatorPadding = const EdgeInsets.symmetric(horizontal: 3),
    @Deprecated("no longer used, use `shouldShowDays` instead")
        this.withDays = true,
    this.showZeroValue = false,
    @Deprecated("no longer used") this.fade = false,
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Color(0xFFF23333),
    ),
    this.curve = Curves.easeOut,
    this.countUp = false,
    this.infinityCountUp = false,
    this.slideAnimationDuration = const Duration(milliseconds: 300),
    this.textDirection,
    this.digitsNumber,
    this.streamDuration,
    this.onChanged,
    this.shouldShowDays,
    this.shouldShowHours,
    this.shouldShowMinutes,
    this.shouldShowSeconds,
  }) : super(key: key);

  /// [Duration] is the duration of the countdown slide,
  /// if the duration has finished it will call [onDone]
  final Duration duration;

  /// [TextStyle] is a parameter for all existing text,
  /// if this is null [SlideCountdown] has a default
  /// text style which will be of all text
  final TextStyle textStyle;

  /// [TextStyle] is a parameter for all existing text,
  /// if this is null [SlideCountdown] has a default
  /// text style which will be of all text
  final TextStyle? separatorStyle;

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

  /// if you want to change the separator type, change this value to
  /// [SeparatorType.title] or [SeparatorType.symbol].
  /// [SeparatorType.title] will display title between duration,
  /// e.g minutes or you can change to another language, by changing the value in [DurationTitle]
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

  /// if the remaining duration is less than one day,
  /// but you want to display the digits of the day, set the value to true.
  /// Make sure the [showZeroValue] property is also true
  final bool withDays;

  /// if you initialize it with false, the duration which is empty will not be displayed
  final bool showZeroValue;

  /// if you want [slideDirection] animation that is not rough set this value to true
  final bool fade;

  /// you can change the slide animation up or down by changing the enum value in this property
  final SlideDirection slideDirection;

  /// to customize curve in [TextAnimation] you can change the default value
  /// default [Curves.easeOut]
  final Curve curve;

  ///this property allows you to do a count up, give it a value of true to do it
  final bool countUp;

  /// if you set this property value to true, it will do the count up continuously or infinity
  /// and the [onDone] property will never be executed,
  /// before doing that you need to set true to the [countUp] property,
  final bool infinityCountUp;

  /// SlideAnimationDuration which will be the duration of the slide animation from above or below
  final Duration slideAnimationDuration;

  /// Text direction for change row positions of each item
  /// ltr => [01] : [02] : [03]
  /// rtl => [03] : [02] : [01]
  final TextDirection? textDirection;

  /// Override digits number
  /// Default 0-9
  final List<String>? digitsNumber;

  /// If you ovveride [StreamDuration] package for stream a duration
  /// property [duration], [countUp], [infinityCountUp], and [onDone] in [SlideCountdown] not affected
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

  @override
  _SlideCountdownState createState() => _SlideCountdownState();
}

class _SlideCountdownState extends State<SlideCountdown> with CountdownMixin {
  late StreamDuration _streamDuration;
  late NotifiyDuration _notifiyDuration;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _notifiyDuration = NotifiyDuration(widget.duration);
    _disposed = false;
    _streamDurationListener();
    _updateConfigurationNotifier(widget.duration);
  }

  @override
  void didUpdateWidget(covariant SlideCountdown oldWidget) {
    if (widget.countUp != oldWidget.countUp ||
        widget.infinityCountUp != oldWidget.infinityCountUp) {
      _streamDuration.dispose();
      _streamDurationListener();
    }
    if (widget.duration != oldWidget.duration) {
      _streamDuration.changeDuration(widget.duration);
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
    _streamDuration = widget.streamDuration ??
        StreamDuration(
          widget.duration,
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
        _streamDuration.durationLeft.listen(
          (duration) {
            _notifiyDuration.streamDuration(duration);
            updateValue(duration);
            if (widget.onChanged != null) {
              widget.onChanged!(duration);
            }
          },
        );
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
    );
  }

  @override
  void dispose() {
    _disposed = true;
    _streamDuration.dispose();
    super.dispose();
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

        final days = DigitItem(
          firstDigit: daysFirstDigitNotifier,
          secondDigit: daysSecondDigitNotifier,
          textStyle: widget.textStyle,
          separatorStyle: widget.separatorStyle ?? widget.textStyle,
          slideDirection: widget.slideDirection,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.days
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: widget.textDirection,
          fade: widget.fade,
          digitsNumber: widget.digitsNumber,
          showSeparator: showHours || showMinutes || showSeconds,
        );

        final hours = DigitItem(
          firstDigit: hoursFirstDigitNotifier,
          secondDigit: hoursSecondDigitNotifier,
          textStyle: widget.textStyle,
          separatorStyle: widget.separatorStyle ?? widget.textStyle,
          slideDirection: widget.slideDirection,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.hours
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: widget.textDirection,
          fade: widget.fade,
          digitsNumber: widget.digitsNumber,
          showSeparator: showMinutes || showSeconds,
        );

        final minutes = DigitItem(
          firstDigit: minutesFirstDigitNotifier,
          secondDigit: minutesSecondDigitNotifier,
          textStyle: widget.textStyle,
          separatorStyle: widget.separatorStyle ?? widget.textStyle,
          slideDirection: widget.slideDirection,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.minutes
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: widget.textDirection,
          fade: widget.fade,
          digitsNumber: widget.digitsNumber,
          showSeparator:
              showSeconds || widget.separatorType == SeparatorType.title,
        );

        final seconds = DigitItem(
          firstDigit: secondsFirstDigitNotifier,
          secondDigit: secondsSecondDigitNotifier,
          textStyle: widget.textStyle,
          separatorStyle: widget.separatorStyle ?? widget.textStyle,
          slideDirection: widget.slideDirection,
          curve: widget.curve,
          countUp: widget.countUp,
          slideAnimationDuration: widget.slideAnimationDuration,
          separator: widget.separatorType == SeparatorType.title
              ? durationTitle.seconds
              : separator,
          separatorPadding: widget.separatorPadding,
          textDirection: widget.textDirection,
          fade: widget.fade,
          digitsNumber: widget.digitsNumber,
          showSeparator: widget.separatorType == SeparatorType.title,
        );

        final daysWidget = showDays ? days : const SizedBox.shrink();

        final hoursWidget = showHours ? hours : const SizedBox.shrink();

        final minutesWidget = showMinutes ? minutes : const SizedBox.shrink();

        final secondsWidget = showSeconds ? seconds : const SizedBox.shrink();

        final countdown = Padding(
          padding: widget.padding,
          child: Row(
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
          ),
        );
        return DecoratedBox(
          decoration: widget.decoration,
          child: countdown,
        );
      },
      child: widget.replacement,
    );
  }
}
