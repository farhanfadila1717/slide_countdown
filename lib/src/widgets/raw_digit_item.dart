import 'package:flutter/material.dart';
import 'package:slide_countdown/src/utils/enum.dart';
import 'package:slide_countdown/src/utils/extensions.dart';
import 'package:slide_countdown/src/utils/utils.dart';

const _kDefaultAnimationDuration = Duration(milliseconds: 250);

/// {@template raw_digit_item}
/// Represents an animated digit item that can count up or down
/// based on the provided [duration].
///
/// Example:
/// ```dart
///    RawDigitItem(
///       duration: remainingDuration,
///       timeUnit: TimeUnit.seconds,
///       digitType: DigitType.second,
///       countUp: false,
///     )
/// ```
/// {@endtemplate}
class RawDigitItem extends StatefulWidget {
  const RawDigitItem({
    super.key,
    required this.duration,
    required this.timeUnit,
    required this.digitType,
    required this.countUp,
    this.slideDirection = SlideDirection.down,
    this.digitsNumber,
    this.style,
  });

  final Duration duration;
  final TimeUnit timeUnit;
  final DigitType digitType;
  final SlideDirection slideDirection;
  final bool countUp;
  final TextStyle? style;
  final OverrideDigits? digitsNumber;

  @override
  State<RawDigitItem> createState() => _RawDigitItemState();
}

class _RawDigitItemState extends State<RawDigitItem>
    with TickerProviderStateMixin {
  late final AnimationController _controllerOne;
  late final AnimationController _controllerTwo;
  late final Animation<Offset> _offsetAnimationOne;
  late final Animation<Offset> _offsetAnimationTwo;

  bool _isOneFirstPlaying = false;

  @override
  void initState() {
    super.initState();
    _controllerOne = AnimationController(
      vsync: this,
      duration: _kDefaultAnimationDuration,
      debugLabel:
          'RawDigitItem-${widget.timeUnit.name}-${widget.digitType.name}',
    );
    _controllerTwo = AnimationController(
      vsync: this,
      duration: _kDefaultAnimationDuration,
      debugLabel:
          'RawDigitItem-${widget.timeUnit.name}-${widget.digitType.name}',
    );

    _offsetAnimationOne = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 1.0),
    ).animate(
      CurvedAnimation(
        parent: _controllerOne,
        curve: Curves.linear,
      ),
    );

    _offsetAnimationTwo = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 1.0),
    ).animate(
      CurvedAnimation(
        parent: _controllerTwo,
        curve: Curves.linear,
      ),
    );

    playAnimation();
  }

  void playAnimation() {
    _isOneFirstPlaying = digitValue().isOdd;

    if (_isOneFirstPlaying) {
      playHalfControllerOne();
    } else {
      playHalfControllerTwo();
    }
  }

  void playHalfControllerOne() async {
    await _controllerOne.animateTo(
      0.5,
      duration: const Duration(milliseconds: 250),
    );

    if (currentAndNextIsZero) return;

    await Future.delayed(
      Duration(milliseconds: 500),
    );

    await _controllerOne.animateTo(
      1.0,
      duration: const Duration(milliseconds: 250),
    );

    _controllerOne.reset();
  }

  void playHalfControllerTwo() async {
    await _controllerTwo.animateTo(
      0.5,
      duration: const Duration(milliseconds: 250),
    );

    if (currentAndNextIsZero) return;

    await Future.delayed(
      Duration(milliseconds: 500),
    );

    await _controllerTwo.animateTo(
      1.0,
      duration: const Duration(milliseconds: 250),
    );

    _controllerTwo.reset();
  }

  Duration get duration => widget.duration;

  int digitValue([Duration? forceDuration]) {
    int value = 0;
    final record = (widget.timeUnit, widget.digitType);

    switch (record) {
      case (TimeUnit.days, DigitType.daysThousand):
        value = (forceDuration ?? duration).daysThousandDigit;
        break;
      case (TimeUnit.days, DigitType.daysHundred):
        value = (forceDuration ?? duration).daysHundredDigit;
        break;
      case (TimeUnit.days, DigitType.first):
        value = (forceDuration ?? duration).daysFirstDigit;
        break;
      case (TimeUnit.days, DigitType.second):
        value = (forceDuration ?? duration).daysLastDigit;
        break;
      case (TimeUnit.hours, DigitType.first):
        value = (forceDuration ?? duration).hoursFirstDigit;
        break;
      case (TimeUnit.hours, DigitType.second):
        value = (forceDuration ?? duration).hoursSecondDigit;
        break;
      case (TimeUnit.minutes, DigitType.first):
        value = (forceDuration ?? duration).minutesFirstDigit;
        break;
      case (TimeUnit.minutes, DigitType.second):
        value = (forceDuration ?? duration).minutesSecondDigit;
        break;
      case (TimeUnit.seconds, DigitType.first):
        value = (forceDuration ?? duration).secondsFirstDigit;
        break;
      case (TimeUnit.seconds, DigitType.second):
        value = (forceDuration ?? duration).secondsSecondDigit;
        break;
      default:
    }

    return value;
  }

  int get currentValue => digitValue();

  int get nextValue => !widget.countUp ? digitValue() + 1 : digitValue() - 1;

  bool get isDirectionUp => widget.slideDirection == SlideDirection.up;

  bool get isWithoutAnimation => widget.slideDirection == SlideDirection.none;

  bool get currentAndNextIsZero {
    if (widget.countUp) return false;

    return digitValue() ==
        digitValue(
          widget.duration - Duration(seconds: 1),
        );
  }

  String digit(int value) =>
      widget.digitsNumber != null ? widget.digitsNumber![value] : '$value';

  @override
  void didUpdateWidget(covariant RawDigitItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      playAnimation();
    }
  }

  int minMaxValue(int value) {
    if (value.isNegative) return 0;

    if (value > 9) return 9;

    return value;
  }

  @override
  void dispose() {
    _controllerOne.dispose();
    _controllerTwo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isWithoutAnimation) {
      return Text(
        digit(currentValue),
        style: widget.style,
      );
    }

    return ClipRRect(
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controllerTwo,
            builder: (_, __) {
              final translation = _offsetAnimationTwo.value;
              return FractionalTranslation(
                translation: translation,
                child: Text(
                  digit(
                    minMaxValue(_isOneFirstPlaying ? nextValue : currentValue),
                  ),
                  style: widget.style,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _controllerOne,
            builder: (_, __) {
              final translation = _offsetAnimationOne.value;

              return FractionalTranslation(
                translation: translation,
                child: Text(
                  digit(
                    minMaxValue(_isOneFirstPlaying ? currentValue : nextValue),
                  ),
                  style: widget.style,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
