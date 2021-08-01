part of 'slide_countdown.dart';

class TextOffsetAnimation extends StatelessWidget {
  const TextOffsetAnimation({
    Key? key,
    required this.slideDirection,
    required Animation<Offset> offsetAnimationOne,
    required this.nextValue,
    required Animation<Offset> offsetAnimationTwo,
    required this.currentValue,
    required this.textStyle,
  })  : _offsetAnimationOne = offsetAnimationOne,
        _offsetAnimationTwo = offsetAnimationTwo,
        super(key: key);

  final SlideDirection slideDirection;
  final Animation<Offset> _offsetAnimationOne;
  final int nextValue;
  final Animation<Offset> _offsetAnimationTwo;
  final int currentValue;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FractionalTranslation(
          translation: slideDirection == SlideDirection.down
              ? _offsetAnimationOne.value
              : -_offsetAnimationOne.value,
          child: Text(
            '$nextValue',
            style: textStyle,
            textScaleFactor: 1.0,
          ),
        ),
        FractionalTranslation(
          translation: slideDirection == SlideDirection.down
              ? _offsetAnimationTwo.value
              : -_offsetAnimationTwo.value,
          child: Text(
            '$currentValue',
            style: textStyle,
            textScaleFactor: 1.0,
          ),
        ),
      ],
    );
  }
}
