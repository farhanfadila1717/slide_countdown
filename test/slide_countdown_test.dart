import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slide_countdown/slide_countdown.dart';

const kDuration = Duration(hours: 3);
const kFullDuration = Duration(days: 2);

void main() {
  group('SlideCountDown Test', () {
    testWidgets(
      'Hide Zero Value is True',
      (tester) async {
        final widget = SlideCountdown(
          duration: kDuration,
          showZeroValue: false,
          separatorType: SeparatorType.title,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(child: widget),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final days = find.text('days');

        expect(days, findsNothing);

        final hours = find.text('hours');

        expect(hours, findsOneWidget);
      },
    );

    testWidgets(
      'Hide Zero Value is False',
      (tester) async {
        final widget = SlideCountdown(
          duration: kDuration,
          showZeroValue: true,
          separatorType: SeparatorType.title,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(child: widget),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final days = find.text('days');

        expect(days, findsOneWidget);
      },
    );

    testWidgets(
      'Custom Separator symbol',
      (tester) async {
        final widget = SlideCountdown(
          duration: kDuration,
          separatorType: SeparatorType.symbol,
          separator: '|',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(child: widget),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final separator = find.text('|');

        expect(separator, findsNWidgets(2));
      },
    );

    testWidgets(
      'Custom Separator Duration title',
      (tester) async {
        final widget = SlideCountdown(
          duration: kFullDuration,
          separatorType: SeparatorType.title,
          durationTitle: DurationTitle.ru(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(child: widget),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final days = find.text(DurationTitle.ru().days);
        final hours = find.text(DurationTitle.ru().hours);
        final minutes = find.text(DurationTitle.ru().minutes);
        final seconds = find.text(DurationTitle.ru().seconds);

        expect(days, findsOneWidget);
        expect(hours, findsOneWidget);
        expect(minutes, findsOneWidget);
        expect(seconds, findsOneWidget);
      },
    );

    testWidgets(
      'TextDirection is rtl',
      (tester) async {
        final widget = SlideCountdown(
          duration: kFullDuration,
          separatorType: SeparatorType.title,
          textDirection: TextDirection.rtl,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(child: widget),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final days = find.text('days');
        final hours = find.text('hours');
        final minutes = find.text('minutes');
        final seconds = find.text('seconds');

        expect(days, findsOneWidget);
        expect(hours, findsOneWidget);
        expect(minutes, findsOneWidget);
        expect(seconds, findsOneWidget);
      },
    );
  });
}
