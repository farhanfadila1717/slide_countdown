import 'package:flutter/material.dart';

import 'duration_title.dart';
import 'enum.dart';

abstract class BaseDigits extends StatelessWidget {
  const BaseDigits({
    Key? key,
    required this.duration,
    required this.firstDigit,
    required this.secondDigit,
    required this.textStyle,
    required this.initValue,
    required this.slideDirection,
    required this.showZeroValue,
    required this.curve,
    required this.countUp,
    required this.slideAnimationDuration,
    required this.separatorType,
    required this.durationTitle,
    this.separatorPadding,
    this.separator,
    this.textDirection,
    this.digitsNumber,
  }) : super(key: key);

  final Duration duration;
  final ValueNotifier<int> firstDigit;
  final ValueNotifier<int> secondDigit;
  final TextStyle textStyle;
  final int initValue;
  final SlideDirection slideDirection;
  final bool showZeroValue;
  final Curve curve;
  final bool countUp;
  final Duration slideAnimationDuration;
  final SeparatorType separatorType;
  final DurationTitle durationTitle;
  final EdgeInsets? separatorPadding;
  final String? separator;
  final TextDirection? textDirection;
  final List<String>? digitsNumber;
}
