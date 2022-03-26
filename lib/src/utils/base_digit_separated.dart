import 'package:flutter/material.dart';
import 'duration_title.dart';
import 'enum.dart';

abstract class BaseDigitsSeparated extends StatefulWidget {
  const BaseDigitsSeparated({
    Key? key,
    required this.height,
    required this.width,
    required this.decoration,
    required this.duration,
    required this.firstDigit,
    required this.secondDigit,
    required this.textStyle,
    required this.separatorStyle,
    required this.initValue,
    required this.slideDirection,
    required this.showZeroValue,
    required this.curve,
    required this.countUp,
    required this.slideAnimationDuration,
    required this.separatorType,
    required this.durationTitle,
    required this.gradientColor,
    this.fade,
    this.separatorPadding,
    this.separator,
    this.textDirection,
  }) : super(key: key);

  final double height;
  final double width;
  final Decoration decoration;
  final Duration duration;
  final ValueNotifier<int> firstDigit;
  final ValueNotifier<int> secondDigit;
  final TextStyle textStyle;
  final TextStyle separatorStyle;
  final int initValue;
  final SlideDirection slideDirection;
  final bool showZeroValue;
  final Curve curve;
  final bool countUp;
  final Duration slideAnimationDuration;
  final SeparatorType separatorType;
  final DurationTitle durationTitle;
  final List<Color> gradientColor;
  final bool? fade;
  final EdgeInsets? separatorPadding;
  final String? separator;
  final TextDirection? textDirection;
}
