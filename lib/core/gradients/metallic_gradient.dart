import 'package:flutter/material.dart';

enum MetallicVariant { gold, silver }

class MetallicGradient {
  static BoxDecoration decoration({
    MetallicVariant variant = MetallicVariant.gold,
    double borderRadius = 0,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: RadialGradient(
        center: const Alignment(0.3, 0.3),
        colors: variant == MetallicVariant.gold
            ? const [
                Color(0xFFFFF6A1),
                Color(0xFFFDD400),
                Color(0xFFB38600),
              ]
            : const [
                Color(0xFFFFFFFF),
                Color(0xFFBDC8D1),
                Color(0xFF6E7980),
              ],
        stops: const [0, 0.5, 1],
      ),
    );
  }
}
