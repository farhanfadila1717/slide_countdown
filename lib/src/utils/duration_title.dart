///Duration Title is a class that contains day, hour, minute, second properties.
///which will later show in the view if you assign a value of [SeparatorType.title] to the [SeparatorType] enum
///and you can change the title of the day, hour, minute, and second. For example, you change to Indonesian.
///By default this title will display in English [DurationTitle.en()]
class DurationTitle {
  final String days;
  final String hours;
  final String minutes;
  final String seconds;

  const DurationTitle({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  DurationTitle copyWith({
    String? days,
    String? hours,
    String? minutes,
    String? seconds,
  }) =>
      DurationTitle(
        days: days ?? this.days,
        hours: hours ?? this.hours,
        minutes: minutes ?? this.minutes,
        seconds: seconds ?? this.seconds,
      );

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    } else if (other is DurationTitle &&
        days == other.days &&
        hours == other.hours &&
        minutes == other.minutes &&
        seconds == other.seconds) {
      return true;
    }
    return false;
  }

  factory DurationTitle.id() => const DurationTitle(
        days: 'hari',
        hours: 'jam',
        minutes: 'menit',
        seconds: 'detik',
      );

  factory DurationTitle.idShort() => const DurationTitle(
        days: 'h',
        hours: 'j',
        minutes: 'm',
        seconds: 'd',
      );

  factory DurationTitle.en() => const DurationTitle(
        days: 'days',
        hours: 'hours',
        minutes: 'minutes',
        seconds: 'seconds',
      );

  factory DurationTitle.enShort() => const DurationTitle(
        days: 'd',
        hours: 'h',
        minutes: 'm',
        seconds: 's',
      );

  factory DurationTitle.hy() => const DurationTitle(
        days: 'օր',
        hours: 'ժամ',
        minutes: 'րոպե',
        seconds: 'վարկյան',
      );

  factory DurationTitle.hyShort() => const DurationTitle(
        days: 'օ',
        hours: 'ժ',
        minutes: 'ր',
        seconds: 'վ',
      );
  factory DurationTitle.ru() => const DurationTitle(
        days: 'дней',
        hours: 'часов',
        minutes: 'минут',
        seconds: 'секунд',
      );

  factory DurationTitle.ruShort() => const DurationTitle(
        days: 'д',
        hours: 'ч',
        minutes: 'м',
        seconds: 'с',
      );

  @override
  int get hashCode => <String>[days, hours, minutes, seconds].join().hashCode;
}
