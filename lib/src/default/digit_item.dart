part of 'default.dart';

class DigitItem extends BaseDigits {
  const DigitItem({
    Key? key,
    required ValueNotifier<int> firstDigit,
    required ValueNotifier<int> secondDigit,
    required TextStyle textStyle,
    required TextStyle separatorStyle,
    required SlideDirection slideDirection,
    required Curve curve,
    required bool countUp,
    required Duration slideAnimationDuration,
    required String separator,
    bool? showSeparator,
    EdgeInsets? separatorPadding,
    TextDirection? textDirection,
    List<String>? digitsNumber,
  }) : super(
          key: key,
          firstDigit: firstDigit,
          secondDigit: secondDigit,
          textStyle: textStyle,
          separatorStyle: separatorStyle,
          slideDirection: slideDirection,
          curve: curve,
          countUp: countUp,
          slideAnimationDuration: slideAnimationDuration,
          separator: separator,
          showSeparator: showSeparator ?? true,
          separatorPadding: separatorPadding,
          textDirection: textDirection,
          digitsNumber: digitsNumber,
        );

  @override
  Widget build(BuildContext context) {
    final withOutAnimation = slideDirection == SlideDirection.none;
    final firstDigitWidget = withOutAnimation
        ? TextWithoutAnimation(
            value: firstDigit,
            textStyle: textStyle,
            digitsNumber: digitsNumber,
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
            digitsNumber: digitsNumber,
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
      show: showSeparator,
      separator: separator,
      style: separatorStyle,
    );

    List<Widget> children = textDirection.isRtl
        ? [
            separatorWidget,
            secondDigitWidget,
            firstDigitWidget,
          ]
        : [
            firstDigitWidget,
            secondDigitWidget,
            separatorWidget,
          ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
