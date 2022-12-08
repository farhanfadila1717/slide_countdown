import 'package:flutter/material.dart';
import 'enum.dart';

abstract class BaseDigitsSeparated extends StatelessWidget {
  const BaseDigitsSeparated({
    Key? key,
    required this.height,
    required this.width,
    required this.decoration,
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
    required this.separator,
    required this.showSeparator,
    this.separatorPadding,
    this.textDirection,
    this.digitsNumber,
  }) : super(key: key);

  final double height;
  final double width;
  final Decoration decoration;
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
  final String separator;
  final bool showSeparator;
  final EdgeInsets? separatorPadding;
  final TextDirection? textDirection;
  final List<String>? digitsNumber;
}
