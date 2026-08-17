import 'package:flutter/material.dart';
import 'package:prayer_time/core/theme/app_typography.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.light.bgPrimary,
    extensions: [
      AppColors.light,
      AppTypography.defaultTypography(AppColors.light),
    ],
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.dark.bgPrimary,
    extensions: [
      AppColors.dark,
      AppTypography.defaultTypography(AppColors.dark),
    ],
  );
}
