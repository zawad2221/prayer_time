import 'dart:ui';

abstract class BaseColors {
  // Brand / Primary
  static const Color tealPrimary = Color(0xFF0D5C53);
  static const Color tealLight = Color(0xFF137D70);
  static const Color goldAccent = Color(0xFFD4A359);

  // Light Mode Surfaces & Text
  static const Color lightBg = Color(0xFFF6F8F6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1E2923);
  static const Color lightTextSecondary = Color(0xFF687A70);

  // Dark Mode Surfaces & Text
  static const Color darkBg = Color(0xFF0F1715);
  static const Color darkSurface = Color(0xFF1A2622);
  static const Color darkTextPrimary = Color(0xFFF0F4F2);
  static const Color darkTextSecondary = Color(0xFF94A39A);

  // Neutral Card Overlays / Shadows
  static const Color cardShadowLight = Color(0x0F000000);
  static const Color cardShadowDark = Color(0x3D000000);
}