import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:prayer_time/core/extensions/context_extensions.dart';
import 'package:prayer_time/core/theme/app_spacing.dart';
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
  late final PageController _pageController;
  final int _initialPage = 10000; // Use a large number to allow swiping back
  Madhab _currentMadhab = Madhab.hanafi;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
    _loadSettings();
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
    _pageController.dispose();
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
        title: Text(_currentIndex == 0 ? 'Prayer Times' : 'Settings'),
        centerTitle: true,
        backgroundColor: context.colors.bgPrimary,
        actions: _currentIndex == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.today),
                  tooltip: 'Go to Today',
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        _initialPage,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ]
            : null,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Home View
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              final date = _getDateForPage(index);
              final dayPrayers = PrayerService.getPrayersForDate(
                date,
                _currentMadhab,
              );
              return Center(
                child: SingleChildScrollView(
                  child: PrayerCard(dayPrayers: dayPrayers),
                ),
              );
            },
          ),
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
