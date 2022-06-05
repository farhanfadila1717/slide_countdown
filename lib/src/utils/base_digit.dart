import 'package:flutter/material.dart';

import 'enum.dart';

abstract class BaseDigits extends StatelessWidget {
  const BaseDigits({
    Key? key,
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
    required this.fade,
    this.separatorPadding,
    this.textDirection,
    this.digitsNumber,
  }) : super(key: key);

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
  final bool fade;
  final EdgeInsets? separatorPadding;
  final TextDirection? textDirection;
  final List<String>? digitsNumber;
}
