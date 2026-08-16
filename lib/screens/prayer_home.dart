import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
              final dayPrayers = PrayerService.getPrayersForDate(date, _currentMadhab);
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onTabTapped,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home),
            label: 'Home',),
          NavigationDestination( icon: Icon(Icons.settings),
              label: 'Settings',)
        ],
        indicatorColor: ,
      ),
    );
  }
}
