import 'package:adhan/adhan.dart';
import '../models/prayer_model.dart';

class PrayerService {
  // Default coordinates for Dhaka, Bangladesh
  static const double latitude = 23.8103;
  static const double longitude = 90.4125;

  static DayPrayers getPrayersForDate(DateTime date, Madhab madhab) {
    final myCoordinates = Coordinates(latitude, longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = madhab;

    final dateComponents = DateComponents.from(date);
    final prayerTimes = PrayerTimes(myCoordinates, dateComponents, params);

    final bool isToday = _isToday(date);
    final currentPrayer = isToday ? prayerTimes.currentPrayer() : Prayer.none;
    final nextPrayer = isToday ? prayerTimes.nextPrayer() : Prayer.none;

    final List<PrayerTimeModel> prayers = [
      PrayerTimeModel(
        name: 'Fajr',
        time: prayerTimes.fajr,
        status: _getStatus(Prayer.fajr, currentPrayer, nextPrayer),
      ),
      PrayerTimeModel(
        name: 'Sunrise',
        time: prayerTimes.sunrise,
        status: _getStatus(Prayer.sunrise, currentPrayer, nextPrayer),
      ),
      PrayerTimeModel(
        name: 'Dhuhr',
        time: prayerTimes.dhuhr,
        status: _getStatus(Prayer.dhuhr, currentPrayer, nextPrayer),
      ),
      PrayerTimeModel(
        name: 'Asr',
        time: prayerTimes.asr,
        status: _getStatus(Prayer.asr, currentPrayer, nextPrayer),
      ),
      PrayerTimeModel(
        name: 'Maghrib',
        time: prayerTimes.maghrib,
        status: _getStatus(Prayer.maghrib, currentPrayer, nextPrayer),
      ),
      PrayerTimeModel(
        name: 'Isha',
        time: prayerTimes.isha,
        status: _getStatus(Prayer.isha, currentPrayer, nextPrayer),
      ),
    ];

    return DayPrayers(date: date, prayers: prayers);
  }

  static bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static PrayerStatus _getStatus(Prayer prayer, Prayer current, Prayer next) {
    if (prayer == current) return PrayerStatus.current;
    if (prayer == next) return PrayerStatus.next;
    return PrayerStatus.none;
  }
}
