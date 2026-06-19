import 'package:flutter/material.dart';

enum GemVariant { ruby, sapphire, emerald, amethyst }

class GemGradient {
  static BoxDecoration decoration({
    GemVariant variant = GemVariant.ruby,
    double borderRadius = 0,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: RadialGradient(
        center: const Alignment(0.3, 0.3),
        colors: _colors(variant),
        stops: const [0, 0.6, 1],
      ),
    );
  }

  static List<Color> _colors(GemVariant variant) {
    switch (variant) {
      case GemVariant.ruby:
        return const [
          Color(0xFFFF9BB2),
          Color(0xFFBB0054),
          Color(0xFF3F0018),
        ];
      case GemVariant.sapphire:
        return const [
          Color(0xFFC3E8FF),
          Color(0xFF00668A),
          Color(0xFF001E2C),
        ];
      case GemVariant.emerald:
        return const [
          Color(0xFFA7F3D0),
          Color(0xFF059669),
          Color(0xFF064E3B),
        ];
      case GemVariant.amethyst:
        return const [
          Color(0xFFE9D5FF),
          Color(0xFF8B5CF6),
          Color(0xFF4C1D95),
        ];
    }
  }
}
