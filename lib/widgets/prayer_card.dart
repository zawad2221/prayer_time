import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time/core/extensions/context_extensions.dart';
import 'package:prayer_time/core/theme/app_colors.dart';
import 'package:prayer_time/core/theme/app_spacing.dart';
import '../models/prayer_model.dart';

class PrayerCard extends StatelessWidget {
  final DayPrayers dayPrayers;
  final VoidCallback showNextDay;
  final VoidCallback showPreviousDay;

  const PrayerCard({super.key, required this.dayPrayers, required this.showNextDay, required this.showPreviousDay});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: AppSpacing.defaultSpacing24,
                  color: context.colors.textPrimary,
                  onPressed: () {
                    showPreviousDay();
                  },
                ),
                Column(
                  children: [
                    Text(
                      DateFormat('EEEE, MMM d').format(dayPrayers.date),
                      style: context.typography.subHead1.copyWith(
                        fontSize: AppSpacing.defaultSpacing24,
                      ),
                    ),
                    if (dayPrayers.prayers.any(
                      (value) => value.status == PrayerStatus.current,
                    ))
                      Text(
                        "TODAY'S SCHEDULE",
                        style: context.typography.subHead1.copyWith(
                          fontSize: AppSpacing.defaultSpacing12,
                          color: BaseColors.brown,
                        ),
                      ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  iconSize: AppSpacing.defaultSpacing24,
                  color: context.colors.textPrimary,
                  onPressed: () {
                    showNextDay();
                  },
                ),
              ],
            ),
            const Divider(height: 32),
            ...dayPrayers.prayers.map(
              (prayer) => _buildPrayerRow(context, prayer),
            ),
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
            ? (isCurrent
                  ? Colors.deepPurple.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted
            ? Border.all(
                color: isCurrent ? Colors.deepPurple : Colors.orange,
                width: 2,
              )
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
                  fontWeight: isHighlighted
                      ? FontWeight.bold
                      : FontWeight.normal,
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
                    backgroundColor: isCurrent
                        ? Colors.deepPurple
                        : Colors.orange,
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

class PrayerHeroCard extends StatefulWidget {
  final PrayerTimeModel _nextPrayerTimeModel;
  final VoidCallback _onTimerComplete;

  const PrayerHeroCard({
    super.key,
    required this._nextPrayerTimeModel,
    required this._onTimerComplete,
  });

  @override
  State<PrayerHeroCard> createState() => _PrayerHeroCardState();
}

class _PrayerHeroCardState extends State<PrayerHeroCard> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown();
    });
  }

  @override
  void didUpdateWidget(covariant PrayerHeroCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._nextPrayerTimeModel.time !=
        oldWidget._nextPrayerTimeModel.time) {
      _timer.cancel();
      _updateCountdown();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateCountdown() {
    setState(() {
      _remaining = widget._nextPrayerTimeModel.time.difference(DateTime.now());
      if (_remaining.isNegative) {
        _remaining = Duration.zero;
        _timer.cancel();
        widget._onTimerComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remaining.inHours;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Container(
      margin: EdgeInsets.all(AppSpacing.defaultSpacing16),
      child: AspectRatio(
        aspectRatio: 1.177,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/background_image_2x.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppSpacing.defaultSpacing24,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.colors.transparent,
                    context.colors.brandPrimary.withValues(alpha: .5),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.defaultSpacing24,
                horizontal: AppSpacing.defaultSpacing16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "NEXT PRAYER",
                    style: context.typography.h1.copyWith(
                      fontSize: AppSpacing.defaultSpacing14,
                      color: BaseColors.softAmber100,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.defaultSpacing4),
                  Text(
                    widget._nextPrayerTimeModel.name,
                    style: context.typography.titleHeader.copyWith(
                      color: context.colors.white,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.defaultSpacing4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.jm().format(
                          widget._nextPrayerTimeModel.time,
                        ),
                        style: context.typography.body1.copyWith(
                          fontSize: AppSpacing.defaultSpacing24,
                          color: context.colors.white,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.defaultSpacing8),
                      Container(
                        height: AppSpacing.defaultSpacing8,
                        width: AppSpacing.defaultSpacing8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: BaseColors.softAmber100,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.defaultSpacing8),
                      Text(
                        'in ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                        style: context.typography.body1.copyWith(
                          fontSize: AppSpacing.defaultSpacing24,
                          color: context.colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
