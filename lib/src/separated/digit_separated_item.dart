part of 'separated.dart';

class DigitSeparatedItem extends BaseDigitsSeparated {
  const DigitSeparatedItem({
    super.key,
    required super.height,
    required super.width,
    required super.decoration,
    required super.firstDigit,
    required super.secondDigit,
    required super.textStyle,
    required super.separatorStyle,
    required super.initValue,
    required super.slideDirection,
    required super.showZeroValue,
    required super.curve,
    required super.countUp,
    required super.slideAnimationDuration,
    required super.separator,
    required super.textDirection,
    required super.showSeparator,
    super.separatorPadding,
    super.digitsNumber,
  });

  @override
  Widget build(BuildContext context) {
    final withOutAnimation = slideDirection == SlideDirection.none;
    final firstDigitWidget = withOutAnimation
        ? TextWithoutAnimation(
            value: firstDigit,
            textStyle: textStyle,
          )
        : TextAnimation(
            slideAnimationDuration: slideAnimationDuration,
            value: firstDigit,
            textStyle: textStyle,
            slideDirection: slideDirection,
            curve: curve,
            countUp: countUp,
            digitsNumber: digitsNumber,
          );

    final secondDigitWidget = withOutAnimation
        ? TextWithoutAnimation(
            value: secondDigit,
            textStyle: textStyle,
          )
        : TextAnimation(
            slideAnimationDuration: slideAnimationDuration,
            value: secondDigit,
            textStyle: textStyle,
            slideDirection: slideDirection,
            curve: curve,
            countUp: countUp,
            digitsNumber: digitsNumber,
          );

    final separatorWidget = Separator(
      padding: separatorPadding,
      show: true,
      separator: separator,
      style: separatorStyle,
    );

    final box = BoxSeparated(
      height: height,
      width: width,
      decoration: decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: textDirection.isRtl
            ? [secondDigitWidget, firstDigitWidget]
            : [
                firstDigitWidget,
                secondDigitWidget,
              ],
      ),
    );

    return Visibility(
      visible: showSeparator,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: textDirection.isRtl
            ? [
                separatorWidget,
                box,
              ]
            : [
                box,
                separatorWidget,
              ],
      ),
      replacement: box,
    );
  }
}
