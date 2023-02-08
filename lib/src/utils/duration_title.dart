// ignore_for_file: public_member_api_docs, sort_constructors_first
/// {@template duration_title}
/// Duration Title is a class that contains day, hour, minute, second properties.
/// which will later show in the view if you assign a value of [SeparatorType.title] to the [SeparatorType] enum
/// and you can change the title of the day, hour, minute, and second. For example, you change to Indonesian.
/// By default this title will display in English [DurationTitle.en()]
/// {@endtemplate}
class DurationTitle {
  /// {@macro duration_title}
  const DurationTitle({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  /// The title for days
  final String days;

  /// The title for hours
  final String hours;

  /// The title for minutes
  final String minutes;

  /// The title for seconds
  final String seconds;

  /// The copyWith method creates a new instance of the `DurationTitle`
  /// class with any of the values modified, if specified.
  /// If a value is not specified, the existing value from the current instance is used.
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

  factory DurationTitle.el() => const DurationTitle(
        days: 'μέρες',
        hours: 'ώρες',
        minutes: 'λεπτά',
        seconds: 'δευτερόλεπτα',
      );

  factory DurationTitle.elShort() => const DurationTitle(
        days: 'μ',
        hours: 'ώ',
        minutes: 'λ',
        seconds: 'δ',
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

  factory DurationTitle.ar() => const DurationTitle(
        days: 'أيام',
        hours: 'ساعات',
        minutes: 'دقائق',
        seconds: 'ثواني',
      );

  factory DurationTitle.arShort() => const DurationTitle(
        days: 'ي',
        hours: 'س',
        minutes: 'د',
        seconds: 'ث',
      );

  @override
  bool operator ==(covariant DurationTitle other) {
    if (identical(this, other)) return true;

    return other.days == days &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.seconds == seconds;
  }

  @override
  int get hashCode {
    return days.hashCode ^ hours.hashCode ^ minutes.hashCode ^ seconds.hashCode;
  }
}
