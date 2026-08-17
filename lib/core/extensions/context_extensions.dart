import 'package:flutter/material.dart';
import 'package:prayer_time/core/theme/app_colors.dart';

extension BuildContextThemeX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
