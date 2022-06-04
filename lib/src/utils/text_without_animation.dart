import 'package:flutter/material.dart';

class TextWithoutAnimation extends StatefulWidget {
  const TextWithoutAnimation({
    Key? key,
    required this.value,
    required this.textStyle,
    required this.initValue,
    this.digitsNumber,
  }) : super(key: key);

  final ValueNotifier<int> value;
  final TextStyle textStyle;
  final int initValue;
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
