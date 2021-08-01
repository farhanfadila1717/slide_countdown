import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../example/example_slide_countdown.dart';

void main() {
  testWidgets('Slidecountdown Test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byWidget(SlideCountdown(duration: const Duration(days: 11))),
        Widget);
    expect(find.text('1'), findsNothing);
    await tester.pump();
  });
}
