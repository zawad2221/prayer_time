import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'notifiers/theme_notifier.dart';
import 'screens/prayer_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await themeNotifier.loadTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'Prayer Time App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeNotifier.themeMode,
          home: const PrayerHomeScreen(),
        );
      },
    );
  }
}
