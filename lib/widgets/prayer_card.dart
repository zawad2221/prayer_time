import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/prayer_model.dart';

class PrayerCard extends StatelessWidget {
  final DayPrayers dayPrayers;

  const PrayerCard({super.key, required this.dayPrayers});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat('EEEE, MMMM d, y').format(dayPrayers.date),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
            ),
            const Divider(height: 32),
            ...dayPrayers.prayers.map((prayer) => _buildPrayerRow(context, prayer)),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerRow(BuildContext context, PrayerTimeModel prayer) {
    final bool isHighlighted = prayer.status != PrayerStatus.none;
    final bool isCurrent = prayer.status == PrayerStatus.current;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlighted
            ? (isCurrent ? Colors.deepPurple.withOpacity(0.1) : Colors.orange.withOpacity(0.1))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted
            ? Border.all(color: isCurrent ? Colors.deepPurple : Colors.orange, width: 2)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                prayer.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (isHighlighted)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Chip(
                    label: Text(
                      isCurrent ? 'Current' : 'Next',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    backgroundColor: isCurrent ? Colors.deepPurple : Colors.orange,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
            ],
          ),
          Text(
            DateFormat.jm().format(prayer.time),
            style: TextStyle(
              fontSize: 18,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
