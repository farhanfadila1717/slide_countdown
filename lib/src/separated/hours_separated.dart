part of 'separated.dart';

class HoursSeparatedDigit extends BaseDigitsSeparated {
  const HoursSeparatedDigit({
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
        );

  @override
  State<HoursSeparatedDigit> createState() => _HoursSeparatedDigitState();
}

class _HoursSeparatedDigitState extends State<HoursSeparatedDigit> {
  @override
  Widget build(BuildContext context) {
    final duration = widget.duration;
    if (duration.inHours < 1 && !widget.showZeroValue) {
      return const SizedBox.shrink();
    }
    final firstDigit = TextAnimation(
      slideAnimationDuration: widget.slideAnimationDuration,
      value: widget.firstDigit,
      textStyle: widget.textStyle,
      slideDirection: widget.slideDirection,
      curve: widget.curve,
      countUp: widget.countUp,
    );

    final secondDigit = TextAnimation(
      slideAnimationDuration: widget.slideAnimationDuration,
      value: widget.secondDigit,
      textStyle: widget.textStyle,
      slideDirection: widget.slideDirection,
      curve: widget.curve,
      countUp: widget.countUp,
    );

    final separator = Separator(
      padding: widget.separatorPadding,
      show: true,
      separator: widget.separatorType == SeparatorType.title
          ? widget.durationTitle.hours
          : widget.separator ?? ':',
      style: widget.separatorStyle,
    );

    final box = BoxSeparated(
      height: widget.height,
      width: widget.width,
      decoration: widget.decoration,
      gradientColors: widget.gradientColor,
      fade: widget.fade ?? false,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.textDirection != null &&
                widget.textDirection == TextDirection.rtl
            ? [secondDigit, firstDigit]
            : [firstDigit, secondDigit],
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        box,
        separator,
      ],
    );
  }
}
