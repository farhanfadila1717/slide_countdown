import 'package:flutter/material.dart';
import 'package:slide_countdown/src/utils/enum.dart';
import 'package:slide_countdown/src/utils/utils.dart';

const _kDefaultAnimationDuration = Duration(milliseconds: 250);

class RawDigitItem extends StatefulWidget {
  const RawDigitItem({
    super.key,
    required this.duration,
    required this.timeUnit,
    required this.digitType,
    required this.style,
    required this.slideDirection,
    required this.countUp,
    this.slideAnimationDuration,
    this.digitsNumber,
  });

  final Duration duration;
  final TimeUnit timeUnit;
  final DigitType digitType;
  final TextStyle style;
  final SlideDirection slideDirection;
  final bool countUp;
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

  int currentValue = 0;
  int nextValue = 0;

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
  }

  @override
  void didUpdateWidget(covariant RawDigitItem oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: [],
        );
      },
    );
  }
}
