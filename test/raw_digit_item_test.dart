import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slide_countdown/slide_countdown.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('RawDigitItem initializes correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RawDigitItem(
            duration: Duration(seconds: 10),
            timeUnit: TimeUnit.seconds,
            digitType: DigitType.second,
            countUp: false,
          ),
        ),
      ),
    );

    expect(find.byType(RawDigitItem), findsOneWidget);
  });

  testWidgets('''
RawDigitItem throws error when slide duration is greater than 500
      milliseconds''', (WidgetTester tester) async {
    expect(
      () async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RawDigitItem(
                duration: const Duration(seconds: 10),
                timeUnit: TimeUnit.seconds,
                digitType: DigitType.second,
                countUp: false,
                slideAnimationDuration: const Duration(milliseconds: 600),
              ),
            ),
          ),
        );
      },
      throwsAssertionError,
    );
  });

  testWidgets('RawDigitItem counts down correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RawDigitItem(
            duration: Duration(seconds: 10),
            timeUnit: TimeUnit.seconds,
            digitType: DigitType.second,
            countUp: false,
          ),
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('RawDigitItem counts up correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RawDigitItem(
            duration: Duration(seconds: 10),
            timeUnit: TimeUnit.seconds,
            digitType: DigitType.second,
            countUp: true,
          ),
        ),
      ),
    );

    expect(find.text('1'), findsOneWidget);
  });
}
