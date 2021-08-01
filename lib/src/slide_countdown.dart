import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stream_duration/stream_duration.dart';

part 'duration_title.dart';
part 'text_animation.dart';
part 'text_offset_animation.dart';

enum SlideDirection { up, down }
enum SeparatorType { symbol, title }

class NotifiyDuration extends ValueNotifier<Duration> {
  NotifiyDuration(Duration value) : super(value);

  streamDuration(Duration duration) {
    value = duration;
    notifyListeners();
  }
}

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

  @override
  _SlideCountdownState createState() => _SlideCountdownState();
}

class _SlideCountdownState extends State<SlideCountdown> {
  late StreamDuration _streamDuration;

  late NotifiyDuration _notifiyDuration;

  ValueNotifier<int> _daysFirstDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _daysSecondDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _hoursFirstDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _hoursSecondDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _minutesFirstDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _minutesSecondDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _secondsFirstDigitNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> _secondsSecondDigitNotifier = ValueNotifier<int>(0);

  ////--------------------------
  late DurationTitle _durationTitle;

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
  }

  @override
  void didUpdateWidget(covariant SlideCountdown oldWidget) {
    if (widget.durationTitle != null) {
      _durationTitle = widget.durationTitle ?? DurationTitle.en();
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
        return AnimatedContainer(
          padding: widget.padding,
          decoration: widget.decoration,
          duration: const Duration(milliseconds: 300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        fade: widget.fade,
                        value: _daysFirstDigitNotifier,
                        textStyle: widget.textStyle,
                        slideDirection: widget.slideDirection,
                      ),
                      TextAnimation(
                        fade: widget.fade,
                        value: _daysSecondDigitNotifier,
                        textStyle: widget.textStyle,
                        slideDirection: widget.slideDirection,
                        showZeroValue: !(duration.inHours < 1 &&
                            widget.separatorType == SeparatorType.title),
                      ),
                      Visibility(
                        visible: widget.separatorType == SeparatorType.symbol,
                        child: Text(widget.separator ?? ':',
                            style: widget.textStyle),
                        replacement: Padding(
                          padding: widget.separatorPadding,
                          child: Text(_durationTitle.days,
                              style: widget.textStyle),
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
                        fade: widget.fade,
                        value: _hoursFirstDigitNotifier,
                        textStyle: widget.textStyle,
                        slideDirection: widget.slideDirection,
                      ),
                      TextAnimation(
                        fade: widget.fade,
                        value: _hoursSecondDigitNotifier,
                        textStyle: widget.textStyle,
                        slideDirection: widget.slideDirection,
                        showZeroValue: !(duration.inHours < 1 &&
                            widget.separatorType == SeparatorType.title),
                      ),
                      Visibility(
                        visible: widget.separatorType == SeparatorType.symbol,
                        child: Text(widget.separator ?? ':',
                            style: widget.textStyle),
                        replacement: Padding(
                          padding: widget.separatorPadding,
                          child: Text(_durationTitle.hours,
                              style: widget.textStyle),
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
                        fade: widget.fade,
                        value: _minutesFirstDigitNotifier,
                        textStyle: widget.textStyle,
                        slideDirection: widget.slideDirection,
                        showZeroValue: !(duration.inMinutes < 1 &&
                            widget.separatorType == SeparatorType.title),
                      ),
                      TextAnimation(
                        fade: widget.fade,
                        value: _minutesSecondDigitNotifier,
                        textStyle: widget.textStyle,
                        slideDirection: widget.slideDirection,
                        showZeroValue: !(duration.inMinutes < 1 &&
                            widget.separatorType == SeparatorType.title),
                      ),
                      Visibility(
                        visible: widget.separatorType == SeparatorType.symbol,
                        child: Text(widget.separator ?? ':',
                            style: widget.textStyle),
                        replacement: Padding(
                          padding: widget.separatorPadding,
                          child: Text(_durationTitle.minutes,
                              style: widget.textStyle),
                        ),
                      ),
                    ],
                  );
                }
              }),
              TextAnimation(
                fade: widget.fade,
                value: _secondsFirstDigitNotifier,
                textStyle: widget.textStyle,
                slideDirection: widget.slideDirection,
              ),
              TextAnimation(
                fade: widget.fade,
                value: _secondsSecondDigitNotifier,
                textStyle: widget.textStyle,
                slideDirection: widget.slideDirection,
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
          ),
        );
      },
    );
  }
}
