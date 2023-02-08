import 'package:flutter/material.dart';

/// {@template text_without_animation}
/// This is a StatefulWidget class that displays a text without animation.
/// {@endtemplate}
class TextWithoutAnimation extends StatefulWidget {
  /// {@macro text_without_animation}
  const TextWithoutAnimation({
    super.key,
    required this.value,
    required this.textStyle,
    this.digitsNumber,
  }) : assert(!(digitsNumber != null && digitsNumber.length == 9),
            'overwriting the digits of a number must complete a number from 0-9');

  final ValueNotifier<int> value;
  final TextStyle textStyle;
  final List<String>? digitsNumber;

  @override
  State<TextWithoutAnimation> createState() => _TextWithoutAnimationState();
}

class _TextWithoutAnimationState extends State<TextWithoutAnimation> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.value,
      builder: (BuildContext context, int value, Widget? child) {
        return Text(
          digit(value),
          style: widget.textStyle,
        );
      },
    );
  }

  String digit(int value) =>
      widget.digitsNumber != null ? widget.digitsNumber![value] : '$value';
}
