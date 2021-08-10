part of 'slide_countdown.dart';

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

  factory DurationTitle.id() => const DurationTitle(
      days: 'hari', hours: 'jam', minutes: 'menit', seconds: 'detik');
  factory DurationTitle.en() => const DurationTitle(
      days: 'days', hours: 'hours', minutes: 'minutes', seconds: 'seconds');
}
