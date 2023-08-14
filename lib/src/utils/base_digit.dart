import 'package:flutter/material.dart';

import 'enum.dart';

abstract class BaseDigits extends StatelessWidget {
  const BaseDigits({
    super.key,
    required this.firstDigit,
    required this.secondDigit,
    required this.textStyle,
    required this.separatorStyle,
    required this.slideDirection,
    required this.curve,
    required this.countUp,
    required this.slideAnimationDuration,
    required this.separator,
    required this.showSeparator,
    required this.textDirection,
    required this.durationTitle,
    required this.durationTitleStyle,
    required this.durationTitlePadding,
    required this.isShowDurationTitleBelow,
    this.separatorPadding,
    this.digitsNumber,
  });

  final ValueNotifier<int> firstDigit;
  final ValueNotifier<int> secondDigit;
  final TextStyle textStyle;
  final TextStyle separatorStyle;
  final SlideDirection slideDirection;
  final Curve curve;
  final bool countUp;
  final Duration slideAnimationDuration;
  final String separator;
  final bool showSeparator;
  final TextDirection textDirection;
  final EdgeInsets? separatorPadding;
  final List<String>? digitsNumber;
  final String durationTitle;
  final TextStyle durationTitleStyle;
  final double durationTitlePadding;
  final bool isShowDurationTitleBelow;
}
