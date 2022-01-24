import 'package:flutter_test/flutter_test.dart';
import 'package:slide_countdown/slide_countdown.dart';

void main() {
  group(
    'Duration Title Default Test',
    () {
      test(
        'locale id_ID Test',
        () {
          final durationTitle = DurationTitle.id();

          expect('hari', durationTitle.days);
          expect('jam', durationTitle.hours);
          expect('menit', durationTitle.minutes);
          expect('detik', durationTitle.seconds);
        },
      );
      test(
        'en_ES Test',
        () {
          final durationTitle = DurationTitle.en();

          expect('days', durationTitle.days);
          expect('hours', durationTitle.hours);
          expect('minutes', durationTitle.minutes);
          expect('seconds', durationTitle.seconds);
        },
      );
    },
  );

  group(
    'Duration Title Custom Test',
    () {
      test(
        'locale fr-FR Test',
        () {
          final durationTitle = DurationTitle(
            days: 'Tag',
            hours: 'Uhr',
            minutes: 'Uhr',
            seconds: 'zweite',
          );

          expect('Tag', durationTitle.days);
          expect('Uhr', durationTitle.hours);
          expect('Uhr', durationTitle.minutes);
          expect('zweite', durationTitle.seconds);
        },
      );
    },
  );
}
