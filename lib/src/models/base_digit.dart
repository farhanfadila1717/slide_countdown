import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:slide_countdown/src/utils/utils.dart';

/// {@template base_digits}
/// `BaseDigitsSeparated` is an abstract class that provides
/// the basic structure for building a widget that displays
/// two digits separated by a separator, with the ability to
/// animate the transition between values.
/// {@endtemplate}
abstract class BaseDigits extends StatelessWidget {
  /// {@macro base_digits}
  const BaseDigits({
    required this.duration,
    required this.timeUnit,
    required this.padding,
    required this.decoration,
    required this.style,
    required this.separatorStyle,
    required this.slideDirection,
    required this.countUp,
    required this.separator,
    required this.showSeparator,
    required this.textDirection,
    super.key,
    this.separatorPadding,
    this.digitsNumber,
  });

  /// The duration of widget.
  final Duration duration;

  /// The time unit of widget.
  final TimeUnit timeUnit;

  /// The padding of the container.
  final EdgeInsetsGeometry padding;

  /// The decoration to apply to the widget.
  final Decoration decoration;

  /// The style for the text of the digits.
  final TextStyle style;

  /// The style for the separator.
  final TextStyle separatorStyle;

  /// The direction in which the digits should slide during the animation.
  final SlideDirection slideDirection;

  /// Whether to animate the digits counting up or down.
  final bool countUp;

  /// The string to use as the separator.
  final String separator;

  /// Whether or not to display the separator.
  final bool showSeparator;

  /// The direction in which the text should flow.
  final TextDirection textDirection;

  /// Padding to add around the separator.
  final EdgeInsets? separatorPadding;

  /// {@macro override_digits}
  final OverrideDigits? digitsNumber;
}
