import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';

part 'duration_title.dart';
part 'enum.dart';
part 'notifiy_duration.dart';
part 'text_animation.dart';

class SlideCountdown extends StatefulWidget {
  const SlideCountdown({
    Key? key,
    required this.duration,
    this.textStyle =
        const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
    this.icon,
    this.sufixIcon,
    this.separator,
    this.onDone,
    this.durationTitle,
    this.separatorType = SeparatorType.symbol,
    this.slideDirection = SlideDirection.down,
    this.padding = const EdgeInsets.all(5),
    this.separatorPadding = const EdgeInsets.symmetric(horizontal: 3),
    this.showZeroValue = false,
    this.fade = false,
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Color(0xFFF23333),
    ),
    this.curve = Curves.easeOut,
  }) : super(key: key);

  final Duration duration;
  final TextStyle textStyle;
  final Widget? icon;
  final Widget? sufixIcon;
  final String? separator;
  final VoidCallback? onDone;
  final SeparatorType separatorType;
  final DurationTitle? durationTitle;
  final Decoration decoration;
  final EdgeInsets padding;
  final EdgeInsets separatorPadding;
  final bool showZeroValue;
  final bool fade;
  final SlideDirection slideDirection;
  final Curve curve;

  @override
  _SlideCountdownState createState() => _SlideCountdownState();
}

class _SlideCountdownState extends State<SlideCountdown> {
  ValueNotifier<int> _daysFirstDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _daysSecondDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _hoursFirstDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _hoursSecondDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _minutesFirstDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _minutesSecondDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _secondsFirstDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _secondsSecondDigitNotifier = ValueNotifier<int>(0);

  late DurationTitle _durationTitle;
  late StreamDuration _streamDuration;
  late NotifiyDuration _notifiyDuration;
  late Color _textColor;
  late Color _fadeColor;

  @override
  void initState() {
    super.initState();
    _notifiyDuration = NotifiyDuration(widget.duration);
    _streamDuration = StreamDuration(widget.duration, () {
      if (widget.onDone != null) {
        widget.onDone!();
      }
    });

    _streamDuration.durationLeft.listen((event) {
      _notifiyDuration.streamDuration(event);
      _daysFirstDigit(event);
      _daysSecondDigit(event);

      _hoursFirstDigit(event);
      _hoursSecondDigit(event);

      _minutesFirstDigit(event);
      _minutesSecondDigit(event);

      _secondsFirstDigit(event);
      _secondsSecondDigit(event);
    });

    _durationTitle = widget.durationTitle ?? DurationTitle.en();
    _textColor = widget.textStyle.color ?? Colors.white;
    _fadeColor = (widget.textStyle.color ?? Colors.white)
        .withOpacity(widget.fade ? 0 : 1);
  }

  @override
  void didUpdateWidget(covariant SlideCountdown oldWidget) {
    if (widget.durationTitle != null) {
      _durationTitle = widget.durationTitle ?? DurationTitle.en();
    }
    if (widget.textStyle != oldWidget.textStyle ||
        widget.fade != oldWidget.fade) {
      _textColor = widget.textStyle.color ?? Colors.white;
      _fadeColor = (widget.textStyle.color ?? Colors.white)
          .withOpacity(widget.fade ? 0 : 1);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _daysFirstDigit(Duration duration) {
    int calculate = (duration.inDays) ~/ 10;
    if (calculate != _daysFirstDigitNotifier.value) {
      _daysFirstDigitNotifier.value = calculate;
    }
  }

  void _daysSecondDigit(Duration duration) {
    int calculate = (duration.inDays) % 10;
    if (calculate != _daysSecondDigitNotifier.value) {
      _daysSecondDigitNotifier.value = calculate;
    }
  }

  void _hoursFirstDigit(Duration duration) {
    int calculate = (duration.inHours % 24) ~/ 10;
    if (calculate != _hoursFirstDigitNotifier.value) {
      _hoursFirstDigitNotifier.value = calculate;
    }
  }

  void _hoursSecondDigit(Duration duration) {
    int calculate = (duration.inHours % 24) % 10;
    if (calculate != _hoursSecondDigitNotifier.value) {
      _hoursSecondDigitNotifier.value = calculate;
    }
  }

  void _minutesFirstDigit(Duration duration) {
    int calculate = (duration.inMinutes % 60) ~/ 10;
    if (calculate != _minutesFirstDigitNotifier.value) {
      _minutesFirstDigitNotifier.value = calculate;
    }
  }

  void _minutesSecondDigit(Duration duration) {
    int calculate = (duration.inMinutes % 60) % 10;
    if (calculate != _minutesSecondDigitNotifier.value) {
      _minutesSecondDigitNotifier.value = calculate;
    }
  }

  void _secondsFirstDigit(Duration duration) {
    int calculate = (duration.inSeconds % 60) ~/ 10;
    if (calculate != _secondsFirstDigitNotifier.value) {
      _secondsFirstDigitNotifier.value = calculate;
    }
  }

  void _secondsSecondDigit(Duration duration) {
    int calculate = (duration.inSeconds % 60) % 10;
    if (calculate != _secondsSecondDigitNotifier.value) {
      _secondsSecondDigitNotifier.value = calculate;
    }
  }

  void _disposeDaysNotifier() {
    _daysFirstDigitNotifier.dispose();
    _daysSecondDigitNotifier.dispose();
  }

  void _disposeHoursNotifier() {
    _hoursFirstDigitNotifier.dispose();
    _hoursSecondDigitNotifier.dispose();
  }

  void _disposeMinutesNotifier() {
    _minutesFirstDigitNotifier.dispose();
    _minutesSecondDigitNotifier.dispose();
  }

  void _disposeSecondsNotifier() {
    _secondsFirstDigitNotifier.dispose();
    _secondsSecondDigitNotifier.dispose();
  }

  @override
  void dispose() {
    _disposeHoursNotifier();
    _disposeMinutesNotifier();
    _disposeSecondsNotifier();
    _disposeDaysNotifier();
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
                  stops: [0.05, 0.3, 0.7, 0.95],
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: widget.icon != null,
          child: widget.icon ?? const SizedBox.shrink(),
        ),
        Builder(builder: (context) {
          if (duration.inDays < 1 && !widget.showZeroValue) {
            return const SizedBox.shrink();
          } else {
            return Row(
              children: [
                TextAnimation(
                  value: _daysFirstDigitNotifier,
                  textStyle: widget.textStyle,
                  slideDirection: widget.slideDirection,
                  curve: widget.curve,
                ),
                TextAnimation(
                  value: _daysSecondDigitNotifier,
                  textStyle: widget.textStyle,
                  slideDirection: widget.slideDirection,
                  curve: widget.curve,
                  showZeroValue: !(duration.inHours < 1 &&
                      widget.separatorType == SeparatorType.title),
                ),
                Visibility(
                  visible: widget.separatorType == SeparatorType.symbol,
                  child: Text(widget.separator ?? ':', style: widget.textStyle),
                  replacement: Padding(
                    padding: widget.separatorPadding,
                    child: Text(_durationTitle.days, style: widget.textStyle),
                  ),
                ),
              ],
            );
          }
        }),
        Builder(builder: (context) {
          if (duration.inHours < 1 && !widget.showZeroValue) {
            return const SizedBox.shrink();
          } else {
            return Row(
              children: [
                TextAnimation(
                  value: _hoursFirstDigitNotifier,
                  textStyle: widget.textStyle,
                  slideDirection: widget.slideDirection,
                  curve: widget.curve,
                ),
                TextAnimation(
                  value: _hoursSecondDigitNotifier,
                  textStyle: widget.textStyle,
                  slideDirection: widget.slideDirection,
                  curve: widget.curve,
                  showZeroValue: !(duration.inHours < 1 &&
                      widget.separatorType == SeparatorType.title),
                ),
                Visibility(
                  visible: widget.separatorType == SeparatorType.symbol,
                  child: Text(widget.separator ?? ':', style: widget.textStyle),
                  replacement: Padding(
                    padding: widget.separatorPadding,
                    child: Text(_durationTitle.hours, style: widget.textStyle),
                  ),
                ),
              ],
            );
          }
        }),
        Builder(builder: (context) {
          if (duration.inMinutes < 1 &&
              widget.separatorType == SeparatorType.title) {
            return const SizedBox.shrink();
          } else {
            return Row(
              children: [
                TextAnimation(
                  value: _minutesFirstDigitNotifier,
                  textStyle: widget.textStyle,
                  slideDirection: widget.slideDirection,
                  curve: widget.curve,
                  showZeroValue: !(duration.inMinutes < 1 &&
                      widget.separatorType == SeparatorType.title),
                ),
                TextAnimation(
                  value: _minutesSecondDigitNotifier,
                  textStyle: widget.textStyle,
                  slideDirection: widget.slideDirection,
                  curve: widget.curve,
                  showZeroValue: !(duration.inMinutes < 1 &&
                      widget.separatorType == SeparatorType.title),
                ),
                Visibility(
                  visible: widget.separatorType == SeparatorType.symbol,
                  child: Text(widget.separator ?? ':', style: widget.textStyle),
                  replacement: Padding(
                    padding: widget.separatorPadding,
                    child:
                        Text(_durationTitle.minutes, style: widget.textStyle),
                  ),
                ),
              ],
            );
          }
        }),
        TextAnimation(
          value: _secondsFirstDigitNotifier,
          textStyle: widget.textStyle,
          slideDirection: widget.slideDirection,
          curve: widget.curve,
        ),
        TextAnimation(
          value: _secondsSecondDigitNotifier,
          textStyle: widget.textStyle,
          slideDirection: widget.slideDirection,
          curve: widget.curve,
        ),
        Visibility(
          visible: widget.separatorType == SeparatorType.title,
          child: Padding(
            padding: widget.separatorPadding,
            child: Text(_durationTitle.seconds, style: widget.textStyle),
          ),
        ),
        Visibility(
          visible: widget.sufixIcon != null,
          child: widget.sufixIcon ?? const SizedBox.shrink(),
        ),
      ],
    );
  }
}
