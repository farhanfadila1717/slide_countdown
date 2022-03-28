import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';

import 'default/default.dart';
import 'utils/countdown_mixin.dart';
import 'utils/duration_title.dart';
import 'utils/enum.dart';
import 'utils/notifiy_duration.dart';

class SlideCountdown extends StatefulWidget {
  const SlideCountdown({
    Key? key,
    required this.duration,
    this.textStyle =
        const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
    this.icon,
    this.suffixIcon,
    this.separator,
    this.onDone,
    this.durationTitle,
    this.separatorType = SeparatorType.symbol,
    this.slideDirection = SlideDirection.down,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.separatorPadding = const EdgeInsets.symmetric(horizontal: 3),
    this.showZeroValue = false,
    this.fade = false,
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Color(0xFFF23333),
    ),
    this.curve = Curves.easeOut,
    this.countUp = false,
    this.infinityCountUp = false,
    this.slideAnimationDuration = const Duration(milliseconds: 300),
    this.textDirection,
  }) : super(key: key);

  /// [Duration] is the duration of the countdown slide,
  /// if the duration has finished it will call [onDone]
  final Duration duration;

  /// [TextStyle] is a parameter for all existing text,
  /// if this is null [SlideCountdown] has a default
  /// text style which will be of all text
  final TextStyle textStyle;

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

  @override
  _SlideCountdownState createState() => _SlideCountdownState();
}

class _SlideCountdownState extends State<SlideCountdown> with CountdownMixin {
  late StreamDuration _streamDuration;
  late NotifiyDuration _notifiyDuration;
  late Color _textColor;
  late Color _fadeColor;
  bool disposed = false;

  @override
  void initState() {
    super.initState();
    _notifiyDuration = NotifiyDuration(widget.duration);
    disposed = false;
    _streamDurationListener();

    _textColor = widget.textStyle.color ?? Colors.white;
    _fadeColor = (widget.textStyle.color ?? Colors.white)
        .withOpacity(widget.fade ? 0 : 1);
  }

  @override
  void didUpdateWidget(covariant SlideCountdown oldWidget) {
    if (widget.textStyle != oldWidget.textStyle ||
        widget.fade != oldWidget.fade) {
      _textColor = widget.textStyle.color ?? Colors.white;
      _fadeColor = (widget.textStyle.color ?? Colors.white)
          .withOpacity(widget.fade ? 0 : 1);
    }
    if (widget.countUp != oldWidget.countUp ||
        widget.infinityCountUp != oldWidget.infinityCountUp) {
      _streamDuration.dispose();
      _streamDurationListener();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _streamDurationListener() {
    _streamDuration = StreamDuration(
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
    return ValueListenableBuilder(
      valueListenable: _notifiyDuration,
      builder: (BuildContext context, Duration duration, Widget? child) {
        return DecoratedBox(
          decoration: widget.decoration,
          child: ClipRect(
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _fadeColor,
                    _textColor,
                    _textColor,
                    _fadeColor,
                  ],
                  stops: const [0.05, 0.3, 0.7, 0.95],
                ).createShader(rect);
              },
              child: Padding(
                padding: widget.padding,
                child: Visibility(
                  visible: widget.fade,
                  child: countdown(duration),
                  replacement: ClipRect(
                    child: countdown(duration),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget countdown(Duration duration) {
    final leadingIcon = Visibility(
      visible: widget.icon != null,
      child: widget.icon ?? const SizedBox.shrink(),
    );

    final suffixIcon = Visibility(
      visible: widget.suffixIcon != null,
      child: widget.suffixIcon ?? const SizedBox.shrink(),
    );

    final days = DaysDigit(
      duration: duration,
      firstDigit: daysFirstDigitNotifier,
      secondDigit: daysSecondDigitNotifier,
      textStyle: widget.textStyle,
      initValue: 0,
      slideDirection: widget.slideDirection,
      showZeroValue: widget.showZeroValue,
      curve: widget.curve,
      countUp: widget.countUp,
      slideAnimationDuration: widget.slideAnimationDuration,
      separatorType: widget.separatorType,
      separatorPadding: widget.separatorPadding,
      separator: widget.separator,
      durationTitle: widget.durationTitle ?? DurationTitle.en(),
      textDirection: widget.textDirection,
    );

    final hours = HoursDigit(
      duration: duration,
      firstDigit: hoursFirstDigitNotifier,
      secondDigit: hoursSecondDigitNotifier,
      textStyle: widget.textStyle,
      initValue: 0,
      slideDirection: widget.slideDirection,
      showZeroValue: widget.showZeroValue,
      curve: widget.curve,
      countUp: widget.countUp,
      slideAnimationDuration: widget.slideAnimationDuration,
      separatorType: widget.separatorType,
      separatorPadding: widget.separatorPadding,
      separator: widget.separator,
      durationTitle: widget.durationTitle ?? DurationTitle.en(),
      textDirection: widget.textDirection,
    );

    final minutes = MinutesDigit(
      duration: duration,
      firstDigit: minutesFirstDigitNotifier,
      secondDigit: minutesSecondDigitNotifier,
      textStyle: widget.textStyle,
      initValue: 0,
      slideDirection: widget.slideDirection,
      showZeroValue: widget.showZeroValue,
      curve: widget.curve,
      countUp: widget.countUp,
      slideAnimationDuration: widget.slideAnimationDuration,
      separatorType: widget.separatorType,
      separatorPadding: widget.separatorPadding,
      separator: widget.separator,
      durationTitle: widget.durationTitle ?? DurationTitle.en(),
      textDirection: widget.textDirection,
    );

    final seconds = SecondsDigit(
      duration: duration,
      firstDigit: secondsFirstDigitNotifier,
      secondDigit: secondsSecondDigitNotifier,
      textStyle: widget.textStyle,
      initValue: 0,
      slideDirection: widget.slideDirection,
      showZeroValue: widget.showZeroValue,
      curve: widget.curve,
      countUp: widget.countUp,
      slideAnimationDuration: widget.slideAnimationDuration,
      separatorType: widget.separatorType,
      separatorPadding: widget.separatorPadding,
      separator: widget.separator,
      durationTitle: widget.durationTitle ?? DurationTitle.en(),
      textDirection: widget.textDirection,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.textDirection.isRtl
          ? [
              suffixIcon,
              seconds,
              minutes,
              hours,
              days,
              leadingIcon,
            ]
          : [
              leadingIcon,
              days,
              hours,
              minutes,
              seconds,
              suffixIcon,
            ],
    );
  }
}
