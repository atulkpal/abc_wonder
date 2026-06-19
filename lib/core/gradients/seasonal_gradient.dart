import 'package:flutter/material.dart';

enum Season { winter, spring, summer, autumn }

class SeasonalGradient {
  static BoxDecoration decoration({
    Season season = Season.spring,
    double borderRadius = 0,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: _gradient(season),
    );
  }

  static LinearGradient _gradient(Season season) {
    switch (season) {
      case Season.winter:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF5FAFF), Color(0xFFC3E8FF)],
        );
      case Season.spring:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF6E5), Color(0xFFFFD9DF)],
        );
      case Season.summer:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFE66D), Color(0xFFFF9BB2)],
        );
      case Season.autumn:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFD9A8), Color(0xFFFF6B6B)],
        );
    }
  }
}
