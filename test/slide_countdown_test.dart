import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slide_countdown/slide_countdown.dart';

const kDuration = Duration(hours: 3);
const kFullDuration = Duration(days: 2);

void main() {
  group(
    'SlideCountDown Test',
    () {
      testWidgets(
        'Custom Separator symbol',
        (tester) async {
          final widget = SlideCountdown(
            duration: kDuration,
            separator: '|',
            shouldShowDays: (_) => false,
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
          const widget = SlideCountdown(
            duration: kFullDuration,
            separatorType: SeparatorType.title,
          );

          await tester.pumpWidget(
            const MaterialApp(
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

      testWidgets(
        'When duration is Zero, show replacement widget',
        (tester) async {
          const widget = SlideCountdown(
            duration: Duration(seconds: 2),
            replacement: Text(
              'replacement',
            ),
          );

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: Center(child: widget),
              ),
            ),
          );

          final replacementWidget = find.text('replacement');

          expect(replacementWidget, findsNothing);

          await tester.pump(const Duration(seconds: 3));

          expect(replacementWidget, findsOneWidget);
        },
      );

      testWidgets(
        'ShouldShowItems only show days digit',
        (tester) async {
          final widget = SlideCountdown(
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

          expect(separator, findsNothing);
        },
      );
    },
  );
}
