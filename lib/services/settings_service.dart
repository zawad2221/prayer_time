import 'package:shared_preferences/shared_preferences.dart';
import 'package:adhan/adhan.dart';
import '../models/app_theme.dart';

class SettingsService {
  static const String _madhabKey = 'asr_madhab';
  static const String _themeKey = 'app_theme';

  static Future<Madhab> getMadhab() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_madhabKey);
    if (value == 'shafi') {
      return Madhab.shafi;
    }
    // Default to Hanafi
    return Madhab.hanafi;
  }

  static Future<void> setMadhab(Madhab madhab) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_madhabKey, madhab == Madhab.shafi ? 'shafi' : 'hanafi');
  }

  static Future<AppTheme> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_themeKey);
    
    for (var theme in AppTheme.values) {
      if (theme.value == value) return theme;
    }
    return AppTheme.system;
  }

  static Future<void> setTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.value);
  }
}
