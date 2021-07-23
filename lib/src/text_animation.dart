part of 'slide_countdown.dart';

class TextAnimation extends StatefulWidget {
  const TextAnimation({
    Key? key,
    required this.value,
    required this.textStyle,
    required this.slideDirection,
    this.initValue = 0,
    this.showZeroValue = true,
  }) : super(key: key);

  final ValueNotifier<int> value;
  final TextStyle textStyle;
  final int initValue;
  final SlideDirection slideDirection;
  final bool showZeroValue;

  @override
  _TextAnimationState createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimationOne;
  late Animation<Offset> _offsetAnimationTwo;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    _offsetAnimationOne = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(_animationController);

    _offsetAnimationTwo = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 1.0),
    ).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      });

    widget.value.addListener(() {
      if (!_animationController.isCompleted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.value,
      builder: (BuildContext context, int value, Widget? child) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child2) {
            int currentValue = 0;
            int nextValue = 0;

            if (currentValue != value) {
              nextValue = value;
              if (value < 9) {
                currentValue = value + 1;
              } else {
                currentValue = 9;
              }
            } else {
              currentValue = value;
            }

            if (_animationController.isDismissed) {
              currentValue = nextValue;
            }

            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                FractionalTranslation(
                  translation: widget.slideDirection == SlideDirection.down
                      ? _offsetAnimationOne.value
                      : -_offsetAnimationOne.value,
                  child: ClipRect(
                    clipper: ClipHalfRect(
                      percentage: _offsetAnimationOne.value.dy,
                      isUp: true,
                      slideDirection: widget.slideDirection,
                    ),
                    child: Text(
                      '$nextValue',
                      style: widget.textStyle,
                      textScaleFactor: 1.0,
                    ),
                  ),
                ),
                FractionalTranslation(
                  translation: widget.slideDirection == SlideDirection.down
                      ? _offsetAnimationTwo.value
                      : -_offsetAnimationTwo.value,
                  child: ClipRect(
                    clipper: ClipHalfRect(
                      percentage: _offsetAnimationTwo.value.dy,
                      isUp: false,
                      slideDirection: widget.slideDirection,
                    ),
                    child: Text(
                      '$currentValue',
                      style: widget.textStyle,
                      textScaleFactor: 1.0,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
