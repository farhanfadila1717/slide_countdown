import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:slide_countdown/src/utils/text_animation.dart';

const kDuration = Duration(minutes: 3);

void main() {
  late ValueNotifier<int> notifier;

  setUpAll(() {
    notifier = ValueNotifier(0);
  });

  testWidgets('Text animation test', (tester) async {
    final widget = TextAnimation(
      fade: false,
      value: notifier,
      textStyle: TextStyle(),
      slideDirection: SlideDirection.up,
      slideAnimationDuration: const Duration(milliseconds: 200),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: widget,
      ),
    );

    await tester.pumpAndSettle();

    final text1 = find.text("0");

    expect(text1, findsWidgets);

    notifier.value = 1;

    await tester.pumpAndSettle();

    final text2 = find.text("1");

    expect(text2, findsWidgets);
  });
}
