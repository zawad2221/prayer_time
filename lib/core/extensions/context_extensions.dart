import 'package:flutter/material.dart';
import 'package:prayer_time/core/theme/app_colors.dart';
import 'package:prayer_time/core/theme/app_typography.dart';

extension BuildContextThemeX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  AppTypography get typography => Theme.of(this).extension<AppTypography>()!;
}
