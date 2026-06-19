import 'package:flutter/material.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';

class AppTheme {
  AppTheme._();

  static const Color background = Color(0xFFFFF8E7);
  static const Color alphabetColor = Color(0xFFFF6B6B);
  static const Color numberColor = Color(0xFF4ECDC4);
  static const Color daysColor = Color(0xFFFFE66D);
  static const Color monthsColor = Color(0xFFA78BFA);
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color accentPink = Color(0xFFFF85A2);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        error: AppColors.error,
        onError: AppColors.onError,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary, size: 28),
        titleTextStyle: TextStyle(
          color: AppColors.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayHero,
        headlineLarge: AppTypography.headlineLg,
        titleLarge: AppTypography.headlineLgMobile,
        bodyLarge: AppTypography.bodyXl,
        labelLarge: AppTypography.labelBold,
      ),
    );
  }
}
