part of 'slide_countdown.dart';

class TextAnimation extends StatefulWidget {
  const TextAnimation({
    Key? key,
    required this.value,
    required this.textStyle,
    required this.slideDirection,
    this.initValue = 0,
    this.showZeroValue = true,
    this.curve = Curves.easeOut,
  }) : super(key: key);

  final ValueNotifier<int> value;
  final TextStyle textStyle;
  final int initValue;
  final SlideDirection slideDirection;
  final bool showZeroValue;
  final Curve curve;

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
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
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      }));

    widget.value.addListener(() {
      if (!_animationController.isCompleted) {
        _animationController.forward();
      }
    });
  }

  void _digit(int value) {
    if (currentValue != value) {
      nextValue = value;
      if (value < 9) {
        currentValue = value + 1;
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
          builder: (context, textWidget) {
            _digit(value);
            return Stack(
              alignment: Alignment.center,
              children: [
                FractionalTranslation(
                  translation: widget.slideDirection == SlideDirection.down
                      ? _offsetAnimationOne.value
                      : -_offsetAnimationOne.value,
                  child: Text(
                    '$nextValue',
                    style: widget.textStyle,
                    textScaleFactor: 1.0,
                  ),
                ),
                FractionalTranslation(
                  translation: widget.slideDirection == SlideDirection.down
                      ? _offsetAnimationTwo.value
                      : -_offsetAnimationTwo.value,
                  child: Text(
                    '$currentValue',
                    style: widget.textStyle,
                    textScaleFactor: 1.0,
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
