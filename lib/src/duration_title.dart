part of 'slide_countdown.dart';

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

  factory DurationTitle.id() => const DurationTitle(
      days: 'hari', hours: 'jam', minutes: 'menit', seconds: 'detik');
  factory DurationTitle.en() => const DurationTitle(
      days: 'days', hours: 'hours', minutes: 'minutes', seconds: 'seconds');
}
