import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slide_countdown/src/utils/clip_digit.dart';
import 'package:slide_countdown/src/utils/enum.dart';
import 'package:slide_countdown/src/utils/extensions.dart';
import 'package:slide_countdown/src/utils/utils.dart';

const _kDefaultAnimationDuration = Duration(milliseconds: 250);

class RawDigitItem extends StatefulWidget {
  const RawDigitItem({
    super.key,
    required this.duration,
    required this.timeUnit,
    required this.digitType,
    required this.countUp,
    this.slideDirection = SlideDirection.down,
    this.slideAnimationDuration,
    this.digitsNumber,
    this.style,
  });

  final Duration duration;
  final TimeUnit timeUnit;
  final DigitType digitType;
  final SlideDirection slideDirection;
  final bool countUp;
  final TextStyle? style;
  final Duration? slideAnimationDuration;
  final OverrideDigits? digitsNumber;

  @override
  State<RawDigitItem> createState() => _RawDigitItemState();
}

class _RawDigitItemState extends State<RawDigitItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimationOne;
  late final Animation<Offset> _offsetAnimationTwo;

  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.slideAnimationDuration ?? _kDefaultAnimationDuration,
      debugLabel:
          'RawDigitItem-${widget.timeUnit.name}-${widget.digitType.name}',
    );

    _offsetAnimationOne = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(_controller);

    _offsetAnimationTwo = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 1.0),
    ).animate(_controller);

    initValue();
    listenAnimation();
  }

  void listenAnimation() {
    _controller.forward();
    _controller.addStatusListener((status) {
      if (_controller.isAnimating) return;

      if (_controller.isCompleted) {
        _controller.reset();
        initValue();
      }
    });
  }

  int get digitValue {
    int value = 0;
    final record = (widget.timeUnit, widget.digitType);

    switch (record) {
      case (TimeUnit.days, DigitType.daysThousand):
        value = widget.duration.daysThousandDigit;
        break;
      case (TimeUnit.days, DigitType.daysHundred):
        value = widget.duration.daysHundredDigit;
        break;
      case (TimeUnit.days, DigitType.first):
        value = widget.duration.daysFirstDigit;
        break;
      case (TimeUnit.days, DigitType.second):
        value = widget.duration.daysLastDigit;
        break;
      case (TimeUnit.hours, DigitType.first):
        value = widget.duration.hoursFirstDigit;
        break;
      case (TimeUnit.hours, DigitType.second):
        value = widget.duration.hoursSecondDigit;
        break;
      case (TimeUnit.minutes, DigitType.first):
        value = widget.duration.minutesFirstDigit;
        break;
      case (TimeUnit.minutes, DigitType.second):
        value = widget.duration.minutesSecondDigit;
        break;
      case (TimeUnit.seconds, DigitType.first):
        value = widget.duration.secondsFirstDigit;
        break;
      case (TimeUnit.seconds, DigitType.second):
        value = widget.duration.secondsSecondDigit;
        break;
      default:
    }

    return value;
  }

  void initValue() => _currentValue = digitValue;

  int get _nextValue {
    if (widget.countUp) {
      if (_currentValue > 0) {
        return max(0, _currentValue + 1);
      }
      return 0;
    }
    if (_currentValue == 9) {
      return 0;
    }
    return max(0, _currentValue - 1);
  }

  bool get isDirectionUp => widget.slideDirection == SlideDirection.up;

  bool get isWithoutAnimation => widget.slideDirection == SlideDirection.none;

  String digit(int value) =>
      widget.digitsNumber != null ? widget.digitsNumber![value] : '$value';

  @override
  void didUpdateWidget(covariant RawDigitItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      playAnimation();
    }
  }

  void playAnimation() {
    if (_currentValue != digitValue) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isWithoutAnimation) {
      return Text(
        digit(_currentValue),
        style: widget.style,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        var currentValueOffset = _offsetAnimationTwo.value;
        var nextValueOffset = _offsetAnimationOne.value;

        if (isDirectionUp) {
          currentValueOffset = -currentValueOffset;
          nextValueOffset = -nextValueOffset;
        }

        return Stack(
          children: [
            FractionalTranslation(
              translation: nextValueOffset,
              child: ClipRect(
                clipper: ClipHalfRect(
                  isUp: true,
                  percentage: nextValueOffset.dy,
                  slideDirection: widget.slideDirection,
                ),
                child: Text(
                  digit(_nextValue),
                  style: widget.style,
                ),
              ),
            ),
            FractionalTranslation(
              translation: currentValueOffset,
              child: ClipRect(
                clipper: ClipHalfRect(
                  isUp: false,
                  percentage: currentValueOffset.dy,
                  slideDirection: widget.slideDirection,
                ),
                child: Text(
                  digit(_currentValue),
                  style: widget.style,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
