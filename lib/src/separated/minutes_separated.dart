part of 'separated.dart';

class MinutesSeparatedDigit extends BaseDigitsSeparated {
  const MinutesSeparatedDigit({
    Key? key,
    required double height,
    required double width,
    required Decoration decoration,
    required Duration duration,
    required ValueNotifier<int> firstDigit,
    required ValueNotifier<int> secondDigit,
    required TextStyle textStyle,
    required TextStyle separatorStyle,
    required int initValue,
    required SlideDirection slideDirection,
    required bool showZeroValue,
    required Curve curve,
    required bool countUp,
    required Duration slideAnimationDuration,
    required SeparatorType separatorType,
    required DurationTitle durationTitle,
    required List<Color> gradientColor,
    bool? fade,
    EdgeInsets? separatorPadding,
    String? separator,
    TextDirection? textDirection,
    List<String>? digitsNumber,
  }) : super(
          key: key,
          height: height,
          width: width,
          decoration: decoration,
          duration: duration,
          firstDigit: firstDigit,
          secondDigit: secondDigit,
          textStyle: textStyle,
          separatorStyle: separatorStyle,
          initValue: initValue,
          slideDirection: slideDirection,
          showZeroValue: showZeroValue,
          curve: curve,
          countUp: countUp,
          slideAnimationDuration: slideAnimationDuration,
          separatorType: separatorType,
          durationTitle: durationTitle,
          gradientColor: gradientColor,
          fade: fade,
          separatorPadding: separatorPadding,
          separator: separator,
          textDirection: textDirection,
          digitsNumber: digitsNumber,
        );

  @override
  Widget build(BuildContext context) {
    if (duration.inMinutes < 1 && !showZeroValue) {
      return const SizedBox.shrink();
    }
    final firstDigit = TextAnimation(
      slideAnimationDuration: slideAnimationDuration,
      value: this.firstDigit,
      textStyle: textStyle,
      slideDirection: slideDirection,
      curve: curve,
      countUp: countUp,
      digitsNumber: digitsNumber,
    );

    final secondDigit = TextAnimation(
      slideAnimationDuration: slideAnimationDuration,
      value: this.secondDigit,
      textStyle: textStyle,
      slideDirection: slideDirection,
      curve: curve,
      countUp: countUp,
      showZeroValue: true,
      digitsNumber: digitsNumber,
    );

    final separator = Separator(
      padding: separatorPadding,
      show: true,
      separator: separatorType == SeparatorType.title
          ? durationTitle.minutes
          : this.separator ?? ':',
      style: separatorStyle,
    );

    final box = BoxSeparated(
      height: height,
      width: width,
      decoration: decoration,
      gradientColors: gradientColor,
      fade: fade ?? false,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [firstDigit, secondDigit],
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: textDirection.isRtl
          ? [
              separator,
              box,
            ]
          : [
              box,
              separator,
            ],
    );
  }
}
