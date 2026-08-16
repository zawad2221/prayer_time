import 'package:flutter/material.dart';
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          themeMode: themeNotifier.themeMode,
          home: const PrayerHomeScreen(),
        );
      },
    );
  }
}
