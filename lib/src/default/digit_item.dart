part of 'default.dart';

/// {@template digit_item}
/// DigitItem is a [StatelessWidget] that represents a digit and optionally a separator.
/// It is built using [TextAnimation] or [TextWithoutAnimation] widget and [Separator] widget.
/// {@endtemplate}
class DigitItem extends BaseDigits {
  /// {@macro digit_item}
  const DigitItem({
    super.key,
    required super.firstDigit,
    required super.secondDigit,
    required super.textStyle,
    required super.separatorStyle,
    required super.slideDirection,
    required super.curve,
    required super.countUp,
    required super.slideAnimationDuration,
    required super.separator,
    required super.showSeparator,
    required super.textDirection,
    required super.durationTitle,
    required super.durationTitleStyle,
    required super.durationTitlePadding,
    required super.isShowDurationTitleBelow,
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

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
        if (isShowDurationTitleBelow) SizedBox(height: durationTitlePadding),
        if (isShowDurationTitleBelow) Text(durationTitle, style: durationTitleStyle),
      ],
    );
  }
}
