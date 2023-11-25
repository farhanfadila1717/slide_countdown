import 'dart:async';

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
  /// {@macro raw_digit_item}
  const RawDigitItem({
    required this.duration,
    required this.timeUnit,
    required this.digitType,
    required this.countUp,
    super.key,
    this.slideDirection = SlideDirection.down,
    this.digitsNumber,
    this.style,
  });

  /// The duration of the digit.
  final Duration duration;

  /// The time unit of the digit.
  final TimeUnit timeUnit;

  /// The digit type of the digit.
  final DigitType digitType;

  /// The SlideDirection animation of the digit.
  final SlideDirection slideDirection;

  /// Whether to count up or down.
  final bool countUp;

  /// The style of the digit.
  final TextStyle? style;

  /// The custom numbers of digits to display.
  final OverrideDigits? digitsNumber;

  @override
  State<RawDigitItem> createState() => _RawDigitItemState();
}

class _RawDigitItemState extends State<RawDigitItem>
    with TickerProviderStateMixin {
  late final AnimationController _controllerOne;
  late final AnimationController _controllerTwo;
  late Animation<Offset> _offsetAnimationOne;
  late Animation<Offset> _offsetAnimationTwo;

  bool _isOneFirstPlaying = false;

  @override
  void initState() {
    super.initState();
    initOffsetAnimation();
    playAnimation(playHalf: true);
  }

  void initOffsetAnimation() {
    _controllerOne = AnimationController(
      vsync: this,
      duration: _kDefaultAnimationDuration,
      debugLabel:
          'RawDigitItem-One-${widget.timeUnit.name}-${widget.digitType.name}',
    );
    _controllerTwo = AnimationController(
      vsync: this,
      duration: _kDefaultAnimationDuration,
      debugLabel:
          'RawDigitItem-Two-${widget.timeUnit.name}-${widget.digitType.name}',
    );

    _offsetAnimationOne = Tween<Offset>(
      begin: isDirectionUp ? const Offset(0, 1) : const Offset(0, -1),
      end: isDirectionUp ? const Offset(0, -1) : const Offset(0, 1),
    ).animate(
      CurvedAnimation(
        parent: _controllerOne,
        curve: Curves.linear,
      ),
    );

    _offsetAnimationTwo = Tween<Offset>(
      begin: isDirectionUp ? const Offset(0, 1) : const Offset(0, -1),
      end: isDirectionUp ? const Offset(0, -1) : const Offset(0, 1),
    ).animate(
      CurvedAnimation(
        parent: _controllerTwo,
        curve: Curves.linear,
      ),
    );
  }

  void playAnimation({
    bool playHalf = false,
  }) {
    final halfController = halfPlayController();

    _isOneFirstPlaying = digitValue().isOdd;

    if (halfController != null) {
      playNextHalfController(halfController);
    }

    if (_isOneFirstPlaying) {
      playHalfController(_controllerOne);
    } else {
      playHalfController(_controllerTwo);
    }
  }

  AnimationController? halfPlayController() {
    final one = _controllerOne.value;
    final two = _controllerTwo.value;

    if (one == 0.5) return _controllerOne;
    if (two == 0.5) return _controllerTwo;

    return null;
  }

  Future<void> playHalfController(
    AnimationController controller,
  ) async {
    if (!mounted) return;

    await controller.animateTo(
      0.5,
      duration: const Duration(milliseconds: 250),
    );

    return;
  }

  Future<void> playNextHalfController(
    AnimationController controller,
  ) async {
    if (!mounted) return;

    await controller.animateTo(
      1,
      duration: const Duration(milliseconds: 250),
    );

    controller.reset();

    return;
  }

  Future<void> playController(
    AnimationController controller, {
    required bool playHalf,
  }) async {
    if (!mounted) return;

    await playHalfController(controller);
  }

  Duration get duration => widget.duration;

  int digitValue([Duration? forceDuration]) {
    var value = 0;
    final record = (widget.timeUnit, widget.digitType);

    switch (record) {
      case (TimeUnit.days, DigitType.daysThousand):
        value = (forceDuration ?? duration).daysThousandDigit;
      case (TimeUnit.days, DigitType.daysHundred):
        value = (forceDuration ?? duration).daysHundredDigit;
      case (TimeUnit.days, DigitType.first):
        value = (forceDuration ?? duration).daysFirstDigit;
      case (TimeUnit.days, DigitType.second):
        value = (forceDuration ?? duration).daysLastDigit;
      case (TimeUnit.hours, DigitType.first):
        value = (forceDuration ?? duration).hoursFirstDigit;
      case (TimeUnit.hours, DigitType.second):
        value = (forceDuration ?? duration).hoursSecondDigit;
      case (TimeUnit.minutes, DigitType.first):
        value = (forceDuration ?? duration).minutesFirstDigit;
      case (TimeUnit.minutes, DigitType.second):
        value = (forceDuration ?? duration).minutesSecondDigit;
      case (TimeUnit.seconds, DigitType.first):
        value = (forceDuration ?? duration).secondsFirstDigit;
      case (TimeUnit.seconds, DigitType.second):
        value = (forceDuration ?? duration).secondsSecondDigit;
      default:
    }

    return value;
  }

  int get currentValue => digitValue();

  int get nextValue => !widget.countUp ? digitValue() + 1 : digitValue() - 1;

  bool get isDirectionUp => widget.slideDirection == SlideDirection.up;

  bool get isWithoutAnimation => widget.slideDirection == SlideDirection.none;

  bool get currentAndNextIsZero {
    if (widget.countUp) {
      return digitValue() ==
          digitValue(
            widget.duration + const Duration(seconds: 1),
          );
    }

    return digitValue() ==
        digitValue(
          widget.duration - const Duration(seconds: 1),
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
