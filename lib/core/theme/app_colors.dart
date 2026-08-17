import 'package:flutter/material.dart';

abstract class BaseColors {
  // Brand / Primary
  static const Color primary = Color(0xFF0D3B3F);
  static const Color light = Color(0xFF137D70);
  static const Color goldAccent = Color(0xFFD4A359);

  // Champagne Gold Scale
  static const Color champagneGold100 = Color(0xFFE9C176);
  static const Color champagneGold75 = Color(0xBFE9C176);
  static const Color champagneGold50 = Color(0x80E9C176);
  static const Color champagneGold25 = Color(0x40E9C176);
  static const Color champagneGold20 = Color(0x33E9C176);
  static const Color champagneGold10 = Color(0x1AE9C176);
  static const Color champagneGold5 = Color(0x0DE9C176);

  // Deep Bronze Scale
  static const Color deepBronze100 = Color(0xFF785A1A);
  static const Color deepBronze75 = Color(0xBF785A1A);
  static const Color deepBronze50 = Color(0x80785A1A);
  static const Color deepBronze25 = Color(0x40785A1A);
  static const Color deepBronze10 = Color(0x1A785A1A);
  static const Color deepBronze5 = Color(0x0D785A1A);

  // Soft Amber Scale
  static const Color softAmber100 = Color(0xFFFED488);
  static const Color softAmber75 = Color(0xBFFED488);
  static const Color softAmber50 = Color(0x80FED488);
  static const Color softAmber25 = Color(0x40FED488);
  static const Color softAmber10 = Color(0x1AFED488);
  static const Color softAmber5 = Color(0x0DFED488);

  // Slate Scale
  static const Color slate100 = Color(0xFF404849);
  static const Color slate75 = Color(0xBF404849);
  static const Color slate50 = Color(0x80404849);
  static const Color slate25 = Color(0x40404849);
  static const Color slate10 = Color(0x1A404849);
  static const Color slate5 = Color(0x0D404849);

  // Silver Scale
  static const Color silver100 = Color(0xFF9CA3AF);
  static const Color silver75 = Color(0xBF9CA3AF);
  static const Color silver50 = Color(0x809CA3AF);
  static const Color silver25 = Color(0x409CA3AF);
  static const Color silver10 = Color(0x1A9CA3AF);
  static const Color silver5 = Color(0x0D9CA3AF);

  // Light Mode Surfaces & Text
  static const Color lightBg = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1E2923);
  static const Color lightTextSecondary = Color(0xFF687A70);

  // Dark Mode Surfaces & Text
  static const Color darkBg = Color(0xFF0D1B1E);
  static const Color darkSurface = Color(0xFF1A2622);
  static const Color darkTextPrimary = Color(0xFFF0F4F2);
  static const Color darkTextSecondary = Color(0xFF94A39A);

  // Neutral Card Overlays / Shadows
  static const Color cardShadowLight = Color(0x0F000000);
  static const Color cardShadowDark = Color(0x3D000000);
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color bgPrimary;
  final Color surfaceCard;
  final Color activeCardBg;
  final Color textPrimary;
  final Color textSecondary;
  final Color brandAccent;
  final Color badgeGold;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color onSurfaceVariant;
  final Color brandPrimary;

  const AppColors({
    required this.bgPrimary,
    required this.surfaceCard,
    required this.activeCardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.brandAccent,
    required this.badgeGold,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.onSurfaceVariant,
    required this.brandPrimary,
  });

  // Light Theme Color Mapping
  static const light = AppColors(
    bgPrimary: BaseColors.lightBg,
    surfaceCard: BaseColors.lightSurface,
    activeCardBg: BaseColors.primary,
    textPrimary: BaseColors.lightTextPrimary,
    textSecondary: BaseColors.lightTextSecondary,
    brandAccent: BaseColors.primary,
    badgeGold: BaseColors.goldAccent,
    secondaryContainer: BaseColors.champagneGold100,
    onSecondaryContainer: BaseColors.deepBronze100,
    onSurfaceVariant: BaseColors.slate100,
    brandPrimary: BaseColors.primary
  );

  // Dark Theme Color Mapping
  static const dark = AppColors(
    bgPrimary: BaseColors.darkBg,
    surfaceCard: BaseColors.darkSurface,
    activeCardBg: BaseColors.light,
    textPrimary: BaseColors.darkTextPrimary,
    textSecondary: BaseColors.darkTextSecondary,
    brandAccent: BaseColors.light,
    badgeGold: BaseColors.goldAccent,
    secondaryContainer: BaseColors.champagneGold20,
    onSecondaryContainer: BaseColors.champagneGold100,
    onSurfaceVariant: BaseColors.silver100,
    brandPrimary: BaseColors.primary
  );

  @override
  AppColors copyWith({
    Color? bgPrimary,
    Color? surfaceCard,
    Color? activeCardBg,
    Color? textPrimary,
    Color? textSecondary,
    Color? brandAccent,
    Color? badgeGold,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? onSurfaceVariant,
    Color? brandPrimary,
  }) {
    return AppColors(
      bgPrimary: bgPrimary ?? this.bgPrimary,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      activeCardBg: activeCardBg ?? this.activeCardBg,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      brandAccent: brandAccent ?? this.brandAccent,
      badgeGold: badgeGold ?? this.badgeGold,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      brandPrimary: brandPrimary ?? this.brandPrimary
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t)!,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t)!,
      activeCardBg: Color.lerp(activeCardBg, other.activeCardBg, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      brandAccent: Color.lerp(brandAccent, other.brandAccent, t)!,
      badgeGold: Color.lerp(badgeGold, other.badgeGold, t)!,
      secondaryContainer: Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      onSecondaryContainer: Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      onSurfaceVariant: Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!
    );
  }
}
