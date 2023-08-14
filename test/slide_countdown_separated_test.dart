import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:slide_countdown/src/separated/separated.dart';

const kDuration = Duration(hours: 3);
const kFullDuration = Duration(days: 2);
const kDurationHours = Duration(hours: 11);
const kDurationMinutes = Duration(minutes: 59);
const kDurationSeconds = Duration(seconds: 59);

void main() {
  group(
    'SlideCountDownSeparated Test',
    () {
      testWidgets('Separator Type is symbol', (tester) async {
        final widget = SlideCountdownSeparated(
          duration: kDurationMinutes,
          separatorType: SeparatorType.symbol,
          separator: ':',
          shouldShowDays: (_) => false,
          shouldShowHours: (_) => false,
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

      testWidgets(
        'When duration is Zero, show replacement widget',
        (tester) async {
          final widget = SlideCountdownSeparated(
            duration: const Duration(seconds: 2),
            replacement: Text(
              'replacement',
            ),
          );

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: Center(child: widget),
              ),
            ),
          );

          final replacementWidget = find.text('replacement');

          expect(replacementWidget, findsNothing);

          await tester.pump(Duration(seconds: 3));

          expect(replacementWidget, findsOneWidget);
        },
      );
      testWidgets(
        'ShouldShowItems only show days digit',
        (tester) async {
          final widget = SlideCountdownSeparated(
            duration: kFullDuration,
            separator: ':',
            shouldShowDays: (_) => true,
            shouldShowHours: (_) => false,
            shouldShowMinutes: (_) => false,
            shouldShowSeconds: (_) => false,
          );

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: Center(child: widget),
              ),
            ),
          );

          final separator = find.text(':');
          final digitSeparatedItem = find.byType(DigitSeparatedItem);

          expect(digitSeparatedItem, findsOneWidget);
          expect(separator, findsNothing);
        },
      );
    },
  );
}
