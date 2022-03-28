import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';
import 'separated/separated.dart';

import 'utils/countdown_mixin.dart';
import 'utils/duration_title.dart';
import 'utils/enum.dart';
import 'utils/notifiy_duration.dart';
import 'utils/text_animation.dart';

class SlideCountdownSeparated extends StatefulWidget {
  const SlideCountdownSeparated({
    Key? key,
    required this.duration,
    this.height = 30,
    this.width = 30,
    this.textStyle =
        const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
    this.separatorStyle =
        const TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold),
    this.icon,
    this.suffixIcon,
    this.separator,
    this.onDone,
    this.durationTitle,
    this.separatorType = SeparatorType.symbol,
    this.slideDirection = SlideDirection.down,
    this.padding = const EdgeInsets.all(5),
    this.separatorPadding = const EdgeInsets.symmetric(horizontal: 3),
    this.withDays = false,
    this.showZeroValue = false,
    this.fade = false,
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
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

  /// if you give or the remaining [duration] is less than one hour
  /// and the property is set to true, the countdown hours will not show
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

  @override
  _SlideCountdownSeparatedState createState() =>
      _SlideCountdownSeparatedState();
}

class _SlideCountdownSeparatedState extends State<SlideCountdownSeparated>
    with CountdownMixin {
  late StreamDuration _streamDuration;
  late NotifiyDuration _notifiyDuration;
  late Color _textColor;
  late Color _fadeColor;
  late List<Color> _gradienColors;
  bool disposed = false;

  @override
  void initState() {
    super.initState();
    _notifiyDuration = NotifiyDuration(widget.duration);
    _streamDurationListener();
    _textColor = widget.textStyle.color ?? Colors.white;
    _fadeColor = (widget.textStyle.color ?? Colors.white)
        .withOpacity(widget.fade ? 0 : 1);
    _gradienColors = [_fadeColor, _textColor, _textColor, _fadeColor];
  }

  @override
  void didUpdateWidget(covariant SlideCountdownSeparated oldWidget) {
    if (widget.textStyle != oldWidget.textStyle ||
        widget.fade != oldWidget.fade) {
      _textColor = widget.textStyle.color ?? Colors.white;
      _fadeColor = (widget.textStyle.color ?? Colors.white)
          .withOpacity(widget.fade ? 0 : 1);
      _gradienColors = [_fadeColor, _textColor, _textColor, _fadeColor];
    }
    if (widget.countUp != oldWidget.countUp ||
        widget.infinityCountUp != oldWidget.infinityCountUp) {
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
        _streamDuration.durationLeft.listen((duration) {
          _notifiyDuration.streamDuration(duration);
          updateValue(duration);
        });
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
      builder: (_, Duration duration, __) {
        final leadingIcon = Visibility(
          visible: widget.icon != null,
          child: widget.icon ?? const SizedBox.shrink(),
        );

        final suffixIcon = Visibility(
          visible: widget.suffixIcon != null,
          child: widget.suffixIcon ?? const SizedBox.shrink(),
        );

        final days = DaysSeparatedDigit(
          height: widget.height,
          width: widget.width,
          decoration: widget.decoration,
          duration: duration,
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
          separatorType: widget.separatorType,
          durationTitle: widget.durationTitle ?? DurationTitle.en(),
          gradientColor: _gradienColors,
          fade: widget.fade,
          separatorPadding: widget.separatorPadding,
          separator: widget.separator,
          textDirection: widget.textDirection,
        );

        final hours = HoursSeparatedDigit(
          height: widget.height,
          width: widget.width,
          decoration: widget.decoration,
          duration: duration,
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
          separatorType: widget.separatorType,
          durationTitle: widget.durationTitle ?? DurationTitle.en(),
          gradientColor: _gradienColors,
          fade: widget.fade,
          separatorPadding: widget.separatorPadding,
          separator: widget.separator,
          textDirection: widget.textDirection,
        );

        final minutes = MinutesSeparatedDigit(
          height: widget.height,
          width: widget.width,
          decoration: widget.decoration,
          duration: duration,
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
          separatorType: widget.separatorType,
          durationTitle: widget.durationTitle ?? DurationTitle.en(),
          gradientColor: _gradienColors,
          fade: widget.fade,
          separatorPadding: widget.separatorPadding,
          separator: widget.separator,
          textDirection: widget.textDirection,
        );

        final seconds = SecondsSeparatedDigit(
          height: widget.height,
          width: widget.width,
          decoration: widget.decoration,
          duration: duration,
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
          separatorType: widget.separatorType,
          durationTitle: widget.durationTitle ?? DurationTitle.en(),
          gradientColor: _gradienColors,
          fade: widget.fade,
          separatorPadding: widget.separatorPadding,
          separator: widget.separator,
          textDirection: widget.textDirection,
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
      },
    );
  }
}
