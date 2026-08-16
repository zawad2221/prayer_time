import 'package:adhan/adhan.dart';

enum PrayerStatus { none, current, next }

class PrayerTimeModel {
  final String name;
  final DateTime time;
  final PrayerStatus status;

  PrayerTimeModel({
    required this.name,
    required this.time,
    this.status = PrayerStatus.none,
  });
}

class DayPrayers {
  final DateTime date;
  final List<PrayerTimeModel> prayers;

  DayPrayers({
    required this.date,
    required this.prayers,
  });
}
