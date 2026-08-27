import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:prayer_time/core/extensions/context_extensions.dart';
import 'package:prayer_time/core/theme/app_spacing.dart';
import 'package:prayer_time/models/prayer_model.dart';
import '../services/prayer_service.dart';
import '../services/settings_service.dart';
import '../widgets/prayer_card.dart';
import '../widgets/settings_view.dart';

class PrayerHomeScreen extends StatefulWidget {
  const PrayerHomeScreen({super.key});

  @override
  State<PrayerHomeScreen> createState() => _PrayerHomeScreenState();
}

class _PrayerHomeScreenState extends State<PrayerHomeScreen> {
  final int _initialPage = 10000; // Use a large number to allow swiping back
  Madhab _currentMadhab = Madhab.hanafi;
  int _currentIndex = 0;

  late DateTime _initialDate;
  late DateTime _selectedDate;
  late DayPrayers _dayPrayers;
  late DayPrayers _todayPrayers;
  late DayPrayers _tomorrowPrayers;

  @override
  void initState() {
    super.initState();
    initDate();
    _loadSettings();
  }

  void initDate() {
    _initialDate = DateTime.now();
    _selectedDate = _initialDate;
    _todayPrayers = PrayerService.getPrayersForDate(
      _initialDate,
      _currentMadhab,
    );
    _tomorrowPrayers = PrayerService.getPrayersForDate(
      _initialDate.add(Duration(days: 1)),
      _currentMadhab,
    );
    _dayPrayers = PrayerService.getPrayersForDate(
      _selectedDate,
      _currentMadhab,
    );
  }

  void showNextOrPreviousDay(bool nextDay) {
    if (nextDay) {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    } else {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
    }
    _dayPrayers = PrayerService.getPrayersForDate(
      _selectedDate,
      _currentMadhab,
    );
  }

  void resetDate() {
    _selectedDate = _initialDate;
    _dayPrayers = PrayerService.getPrayersForDate(
      _selectedDate,
      _currentMadhab,
    );
  }

  void refreshHeroCardDate() {
    if (DateTime.now() != _initialDate) {
      _initialDate = DateTime.now();
    }
    _todayPrayers = PrayerService.getPrayersForDate(
      _initialDate,
      _currentMadhab,
    );
    _tomorrowPrayers = PrayerService.getPrayersForDate(
      _initialDate.add(Duration(days: 1)),
      _currentMadhab,
    );
  }

  Future<void> _loadSettings() async {
    try {
      final madhab = await SettingsService.getMadhab();
      if (mounted) {
        setState(() {
          _currentMadhab = madhab;
        });
      }
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime _getDateForPage(int page) {
    final int offset = page - _initialPage;
    return DateTime.now().add(Duration(days: offset));
  }

  void _onTabTapped(int index) {
    if (index == 0 && _currentIndex != 0) {
      _loadSettings(); // Reload settings when coming back to home
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? 'Prayer Times' : 'Settings',
          style: context.typography.h3,
        ),
        centerTitle: true,
        backgroundColor: context.colors.bgPrimary,
        actions: (_currentIndex == 0 && _selectedDate != _initialDate)
            ? [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Go to Today',
                  onPressed: () {
                    setState(() {
                      resetDate();

                    });
                  },
                ),
              ]
            : null,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Home View
          _landingView(),
          // Settings View
          SettingsView(
            onSettingsChanged: () {
              // Optionally trigger reload here too, but _onTabTapped handles it
            },
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.defaultSpacing24),
        ),
        child: BottomAppBar(
          elevation: AppSpacing.defaultSpacing24,
          color: context.colors.bgPrimary,
          shadowColor: context.colors.brandPrimary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                icon: Icons.home_outlined,
                iconSelected: Icons.home,
                label: 'Home',
                index: 0,
                context: context,
              ),
              buildNavItem(
                icon: Icons.settings_outlined,
                iconSelected: Icons.settings,
                label: 'Settings',
                index: 1,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _landingView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // top hero card
          PrayerHeroCard(
            nextPrayerTimeModel: _todayPrayers.prayers.firstWhere(
              (value) => value.status == PrayerStatus.next,
              orElse: () => _tomorrowPrayers.prayers.firstWhere(
                (value) => value.status == PrayerStatus.next,
              ),
            ),
            onTimerComplete: () {
              setState(() {
                refreshHeroCardDate();
              });
            },
          ),

          //prayer time pager
          Center(
            child: SingleChildScrollView(
              child: PrayerCard(
                dayPrayers: _dayPrayers,
                showNextDay: () {
                  setState(() {
                    showNextOrPreviousDay(true);
                  });
                },
                showPreviousDay: () {
                  setState(() {
                    showNextOrPreviousDay(false);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem({
    required IconData icon,
    required IconData iconSelected,
    required String label,
    required int index,
    required BuildContext context,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(AppSpacing.defaultSpacing24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.defaultSpacing24,
          vertical: AppSpacing.defaultSpacing4,
        ),
        decoration: BoxDecoration(
          // Background covers BOTH icon and text when selected
          color: isSelected
              ? context.colors.secondaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.defaultSpacing24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? iconSelected : icon,
              color: isSelected
                  ? context.colors.onSecondaryContainer
                  : context.colors.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.defaultSpacing2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF0D3B3F) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
