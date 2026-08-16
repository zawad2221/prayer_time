import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import '../services/settings_service.dart';

class ThemeNotifier extends ValueNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme.system);

  Future<void> loadTheme() async {
    value = await SettingsService.getTheme();
  }

  Future<void> updateTheme(AppTheme newTheme) async {
    value = newTheme;
    await SettingsService.setTheme(newTheme);
  }

  ThemeMode get themeMode {
    switch (value) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
      case AppTheme.system:
        return ThemeMode.system;
    }
  }
}

final themeNotifier = ThemeNotifier();
