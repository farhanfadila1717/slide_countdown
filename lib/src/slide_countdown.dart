import 'package:flutter/material.dart';
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
    this.onDone,
    this.durationTitle,
    this.separatorType = SeparatorType.symbol,
    this.slideDirection = SlideDirection.down,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.separatorPadding = const EdgeInsets.symmetric(horizontal: 3),
    this.withDays = true,
    this.withHours = true,
    this.withMinutes = true,
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

  /// if the remaining duration is less than one hour,
  /// but you want to display the digits of the hour, set the value to true.
  /// Make sure the [showZeroValue] property is also true
  final bool withHours;

  /// if the remaining duration is less than one minute,
  /// but you want to display the digits of the minute, set the value to true.
  /// Make sure the [showZeroValue] property is also true
  final bool withMinutes;

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

  // if you need to stream the remaining available duration,
  // it will be called every time the duration changes.
  final ValueChanged<Duration>? onChanged;

  @override
  _SlideCountdownState createState() => _SlideCountdownState();
}

class _SlideCountdownState extends State<SlideCountdown> with CountdownMixin {
  late StreamDuration _streamDuration;
  late NotifiyDuration _notifiyDuration;
  bool disposed = false;

  @override
  void initState() {
    super.initState();
    _notifiyDuration = NotifiyDuration(widget.duration);
    disposed = false;
    _streamDurationListener();
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

    if (!disposed) {
      try {
        _streamDuration.durationLeft.listen(
          (duration) {
            _notifiyDuration.streamDuration(duration);
            updateValue(duration);
          },
        );
      } catch (ex) {
        debugPrint(ex.toString());
      }
    }
  }

  @override
  void dispose() {
    disposed = true;
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

    return ValueListenableBuilder(
      valueListenable: _notifiyDuration,
      builder: (BuildContext context, Duration duration, Widget? child) {
        if (duration.inSeconds <= 0) return SizedBox.shrink();
        final daysWidget =
            showWidget(duration.inDays, widget.showZeroValue) && widget.withDays
                ? days
                : const SizedBox.shrink();
        final hoursWidget = showWidget(duration.inHours, widget.showZeroValue)
            ? hours
            : const SizedBox.shrink();

        final minutesWidget =
            showWidget(duration.inMinutes, widget.showZeroValue) && widget.withHours
                ? minutes
                : const SizedBox.shrink();

        final secondsWidget =
            showWidget(duration.inSeconds, widget.showZeroValue) && widget.withMinutes
                ? seconds
                : const SizedBox.shrink();

        final child = Padding(
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
          child: child,
        );
      },
    );
  }
}
