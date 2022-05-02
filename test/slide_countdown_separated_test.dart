import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slide_countdown/slide_countdown.dart';

const kDuration = Duration(hours: 3);
const kFullDuration = Duration(days: 2);
const kDurationHours = Duration(hours: 11);
const kDurationMinutes = Duration(minutes: 59);
const kDurationSeconds = Duration(seconds: 59);

void main() {
  group(
    'SlideCountDown Test',
    () {
      testWidgets(
        'Hide Zero Value is True',
        (tester) async {
          final widget = SlideCountdownSeparated(
            duration: kDurationHours,
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

          final separated = find.byType(SlideCountdownSeparated);

          expect(separated, findsOneWidget);

          final days = find.text('days');

          expect(days, findsNothing);

          final hours = find.text('hours');

          expect(hours, findsOneWidget);
        },
      );

      testWidgets(
        'Hide Zero Value is False',
        (tester) async {
          final widget = SlideCountdownSeparated(
            duration: kFullDuration,
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

          final separated = find.byType(SlideCountdownSeparated);

          expect(separated, findsOneWidget);

          final days = find.text('days');

          expect(days, findsOneWidget);
        },
      );

      testWidgets('Separator Type is symbol', (tester) async {
        final widget = SlideCountdownSeparated(
          duration: kDurationMinutes,
          showZeroValue: false,
          separatorType: SeparatorType.symbol,
          separator: ':',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(child: widget),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final separated = find.byType(SlideCountdownSeparated);

        expect(separated, findsOneWidget);

        final separator = find.text(':');

        expect(separator, findsOneWidget);
      });

      testWidgets('Count up', (tester) async {
        final SlideCountdownSeparated widget = SlideCountdownSeparated(
          duration: kDuration,
          countUp: true,
          separatorType: SeparatorType.symbol,
          separator: ':',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(child: widget),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final separated = find.byType(SlideCountdownSeparated);

        expect(separated, findsOneWidget);
        expect(widget.countUp, isTrue);
      });
    },
  );
}
