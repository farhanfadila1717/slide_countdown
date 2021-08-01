part of 'slide_countdown.dart';

class TextAnimation extends StatefulWidget {
  const TextAnimation({
    Key? key,
    required this.value,
    required this.textStyle,
    required this.slideDirection,
    this.initValue = 0,
    this.showZeroValue = true,
    this.fade = false,
  }) : super(key: key);

  final ValueNotifier<int> value;
  final TextStyle textStyle;
  final int initValue;
  final SlideDirection slideDirection;
  final bool showZeroValue;
  final bool fade;

  @override
  _TextAnimationState createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimationOne;
  late Animation<Offset> _offsetAnimationTwo;
  late LinearGradient _shaderGradient;
  late Color _fontColor;
  late double _size;
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
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _offsetAnimationTwo = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 1.0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      });

    _fontColor = widget.textStyle.color ?? Colors.white;
    _size = widget.textStyle.fontSize ?? 14;

    _shaderGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.05, 0.3, 0.7, 0.95],
      colors: [
        _fontColor.withOpacity(0.0),
        _fontColor,
        _fontColor,
        _fontColor.withOpacity(0.0),
      ],
    );

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
  void didUpdateWidget(covariant TextAnimation oldWidget) {
    if (oldWidget.textStyle != widget.textStyle) {
      _size = widget.textStyle.fontSize ?? 14;
    }
    super.didUpdateWidget(oldWidget);
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
        return Visibility(
          visible: widget.fade,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, textWidget) {
              _digit(value);
              return ClipRect(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return _shaderGradient.createShader(bounds);
                  },
                  child: SizedBox(
                    height: _size + (_size * 0.35),
                    child: TextOffsetAnimation(
                      slideDirection: widget.slideDirection,
                      textStyle: widget.textStyle,
                      offsetAnimationOne: _offsetAnimationOne,
                      nextValue: nextValue,
                      offsetAnimationTwo: _offsetAnimationTwo,
                      currentValue: currentValue,
                    ),
                  ),
                ),
              );
            },
          ),
          replacement: AnimatedBuilder(
            animation: _animationController,
            builder: (context, textWidget) {
              _digit(value);
              return ClipRect(
                child: TextOffsetAnimation(
                  slideDirection: widget.slideDirection,
                  textStyle: widget.textStyle,
                  offsetAnimationOne: _offsetAnimationOne,
                  nextValue: nextValue,
                  offsetAnimationTwo: _offsetAnimationTwo,
                  currentValue: currentValue,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
