import 'package:flutter/material.dart';

class AppTheme {
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
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: alphabetColor,
        primary: alphabetColor,
        secondary: numberColor,
        surface: background,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary, size: 28),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: textPrimary,
        ),
      ),
    );
  }
}
