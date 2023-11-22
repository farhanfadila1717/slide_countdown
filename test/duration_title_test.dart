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

      test(
        'locale ar Test',
        () {
          final durationTitle = DurationTitle.ar();

          expect('أيام', durationTitle.days);
          expect('ساعات', durationTitle.hours);
          expect('دقائق', durationTitle.minutes);
          expect('ثواني', durationTitle.seconds);
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
          const durationTitle = DurationTitle(
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

  group('factory coverage', () {
    test(
      'id',
      () {
        const id = DurationTitle(
            days: 'hari', hours: 'jam', minutes: 'menit', seconds: 'detik',);

        expect(id == DurationTitle.id(), isTrue);
        expect(id.hashCode == DurationTitle.id().hashCode, isTrue);
      },
    );
    test(
      'id short',
      () {
        const id =
            DurationTitle(days: 'h', hours: 'j', minutes: 'm', seconds: 'd');

        expect(id == DurationTitle.idShort(), isTrue);
        expect(id.hashCode == DurationTitle.idShort().hashCode, isTrue);
      },
    );

    test(
      'en',
      () {
        const en = DurationTitle(
            days: 'days',
            hours: 'hours',
            minutes: 'minutes',
            seconds: 'seconds',);

        expect(en == DurationTitle.en(), isTrue);
        expect(en.hashCode == DurationTitle.en().hashCode, isTrue);
      },
    );
    test(
      'en short',
      () {
        const en =
            DurationTitle(days: 'd', hours: 'h', minutes: 'm', seconds: 's');

        expect(en == DurationTitle.enShort(), isTrue);
        expect(en.hashCode == DurationTitle.enShort().hashCode, isTrue);
      },
    );
  });

  test(
    'locale el Test',
    () {
      final durationTitle = DurationTitle.el();

      expect('μέρες', durationTitle.days);
      expect('ώρες', durationTitle.hours);
      expect('λεπτά', durationTitle.minutes);
      expect('δευτερόλεπτα', durationTitle.seconds);
    },
  );

  test(
    'locale el short Test',
    () {
      final durationTitle = DurationTitle.elShort();

      expect('μ', durationTitle.days);
      expect('ώ', durationTitle.hours);
      expect('λ', durationTitle.minutes);
      expect('δ', durationTitle.seconds);
    },
  );

  test('Copywith Test', () {
    final en = DurationTitle.en();

    expect(en.hours, 'hours');
    expect(en.days, 'days');
    expect(en.minutes, 'minutes');
    expect(en.seconds, 'seconds');

    final newEn = en.copyWith(
      days: 'Days',
      hours: 'Hours',
      minutes: 'Hours',
      seconds: 'Seconds',
    );

    expect(newEn.days, 'Days');
    expect(newEn.hours, 'Hours');
    expect(newEn.minutes, 'Hours');
    expect(newEn.seconds, 'Seconds');
  });
}
