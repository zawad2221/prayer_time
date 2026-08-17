import 'package:flutter/material.dart';
import 'package:prayer_time/core/theme/app_colors.dart';
import 'package:prayer_time/core/theme/app_spacing.dart';

@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  final TextStyle titleHeader;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle subHead1;
  final TextStyle subHead2;
  final TextStyle subHead3;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle caption;

  const AppTypography({
    required this.titleHeader,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.subHead1,
    required this.subHead2,
    required this.subHead3,
    required this.body1,
    required this.body2,
    required this.caption,
  });

  //default mode typography

  factory AppTypography.defaultTypography(AppColors colors) {
    return AppTypography(
      titleHeader: AppDefaultTypography.TitleHeader.copyWith(
        color: colors.textPrimary,
      ),
      h1: AppDefaultTypography.H1.copyWith(color: colors.textPrimary),
      h2: AppDefaultTypography.H1.copyWith(
        color: colors.textPrimary,
        fontSize: AppSpacing.defaultSpacing28,
      ),
      h3: AppDefaultTypography.H1.copyWith(
        color: colors.textPrimary,
        fontSize: AppSpacing.defaultSpacing24,
      ),
      subHead1: AppDefaultTypography.SubHead1.copyWith(
        color: colors.textPrimary,
      ),
      subHead2: AppDefaultTypography.SubHead1.copyWith(
        color: colors.textPrimary,
        fontSize: AppSpacing.defaultSpacing16,
      ),
      subHead3: AppDefaultTypography.SubHead1.copyWith(
        color: colors.textPrimary,
        fontSize: AppSpacing.defaultSpacing14,
      ),
      body1: AppDefaultTypography.Body1.copyWith(color: colors.textPrimary),
      body2: AppDefaultTypography.Body1.copyWith(
        color: colors.textPrimary,
        fontSize: AppSpacing.defaultSpacing14,
      ),
      caption: AppDefaultTypography.Caption.copyWith(color: colors.textPrimary),
    );
  }

  @override
  AppTypography copyWith({
    TextStyle? titleHeader,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? subHead1,
    TextStyle? subHead2,
    TextStyle? subHead3,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? caption,
  }) {
    return AppTypography(
      titleHeader: titleHeader ?? this.titleHeader,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      subHead1: subHead1 ?? this.subHead1,
      subHead2: subHead2 ?? this.subHead2,
      subHead3: subHead3 ?? this.subHead3,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      caption: caption ?? this.caption,
    );
  }

  @override
  AppTypography lerp(covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }
    return AppTypography(
      titleHeader: TextStyle.lerp(titleHeader, other.titleHeader, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      subHead1: TextStyle.lerp(subHead1, other.subHead1, t)!,
      subHead2: TextStyle.lerp(subHead2, other.subHead2, t)!,
      subHead3: TextStyle.lerp(subHead3, other.subHead3, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
    );
  }
}

abstract class AppDefaultTypography {
  static const _fontFamily = "NotoSerif_Condensed";

  static const TitleHeader = TextStyle(
    fontFamily: _fontFamily,
    fontSize: AppSpacing.defaultSpacing32,
    fontWeight: FontWeight.bold,
  );

  static const H1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: AppSpacing.defaultSpacing32,
    fontWeight: FontWeight.w700,
  );
  static const SubHead1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: AppSpacing.defaultSpacing22,
    fontWeight: FontWeight.w500,
  );
  static const Body1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: AppSpacing.defaultSpacing16,
    fontWeight: FontWeight.w400,
  );
  static const Caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: AppSpacing.defaultSpacing12,
    fontWeight: FontWeight.w500,
  );
}
