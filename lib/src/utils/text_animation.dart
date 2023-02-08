import 'package:flutter/material.dart';

import 'clip_digit.dart';
import 'enum.dart';
import 'utils.dart';

/// {@template text_animation}
/// A [StatefulWidget] that animates the text of an integer `value`
/// when the `value` changes.
/// {@endtemplate}
class TextAnimation extends StatefulWidget {
  /// {@macro text_animation}
  const TextAnimation({
    super.key,
    required this.value,
    required this.textStyle,
    required this.slideDirection,
    required this.slideAnimationDuration,
    this.curve = Curves.easeOut,
    this.countUp = true,
    this.digitsNumber,
  }) : assert(!(digitsNumber != null && digitsNumber.length == 9),
            'overwriting the digits of a number must complete a number from 0-9');

  /// value A [ValueNotifier] that holds the integer value to be displayed.
  final ValueNotifier<int> value;

  /// The text style to be used for the text.
  final TextStyle textStyle;

  /// The direction in which the text should slide during the animation.
  final SlideDirection slideDirection;

  /// The duration of the slide animation.
  final Curve curve;

  /// Indicates whether the text should count up or down.
  final bool countUp;

  /// The duration of the slide animation.
  final Duration slideAnimationDuration;

  /// {@macro override_digits}
  final OverrideDigits? digitsNumber;

  @override
  _TextAnimationState createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimationOne;
  late Animation<Offset> _offsetAnimationTwo;
  int currentValue = 0;
  int nextValue = 0;
  bool disposed = false;

  @override
  void initState() {
    super.initState();
    disposed = false;
    _animationController = AnimationController(
        vsync: this, duration: widget.slideAnimationDuration);
    _offsetAnimationOne = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: widget.curve));

    _offsetAnimationTwo = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 1.0),
    ).animate(CurvedAnimation(parent: _animationController, curve: widget.curve)
      ..addStatusListener((status) {
        if (widget.slideDirection == SlideDirection.none) return;
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      }));

    if (!disposed) {
      widget.value.addListener(() {
        if (widget.slideDirection == SlideDirection.none) return;
        if (!_animationController.isCompleted) {
          if (mounted) {
            _animationController.forward();
          }
        }
      });
    }
  }

  void _digit(int value) {
    if (currentValue != value) {
      nextValue = value;
      if (value < 9) {
        currentValue = widget.countUp
            ? value < 1
                ? value
                : value - 1
            : value + 1;
      } else {
        currentValue = 0;
      }
    } else {
      currentValue = value;
      if (nextValue == 0) {
        currentValue = 1;
      }
    }

    if (_animationController.isDismissed) {
      currentValue = nextValue;
    }
  }

  @override
  void dispose() {
    disposed = true;
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUp = widget.slideDirection == SlideDirection.up;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        _digit(widget.value.value);
        final nextValueOffset =
            isUp ? -_offsetAnimationOne.value : _offsetAnimationOne.value;
        final currentValueOffset =
            isUp ? -_offsetAnimationTwo.value : _offsetAnimationTwo.value;

        return Stack(
          alignment: Alignment.center,
          children: [
            FractionalTranslation(
              translation: nextValueOffset,
              child: ClipRect(
                clipper: ClipHalfRect(
                  isUp: true,
                  slideDirection: widget.slideDirection,
                  percentage: _offsetAnimationOne.value.dy,
                ),
                child: Text(
                  digit(nextValue),
                  style: widget.textStyle,
                ),
              ),
            ),
            FractionalTranslation(
              translation: currentValueOffset,
              child: ClipRect(
                clipper: ClipHalfRect(
                  isUp: false,
                  slideDirection: widget.slideDirection,
                  percentage: _offsetAnimationTwo.value.dy,
                ),
                child: Text(
                  digit(currentValue),
                  style: widget.textStyle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String digit(int value) =>
      widget.digitsNumber != null ? widget.digitsNumber![value] : '$value';
}
