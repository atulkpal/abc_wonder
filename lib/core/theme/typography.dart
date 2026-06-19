import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle displayHero = GoogleFonts.plusJakartaSans(
    textStyle: const TextStyle(fontFamilyFallback: ['sans-serif']),
    fontSize: 48,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.02,
    height: 1.1,
  );

  static TextStyle headlineLg = GoogleFonts.plusJakartaSans(
    textStyle: const TextStyle(fontFamilyFallback: ['sans-serif']),
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle headlineLgMobile = GoogleFonts.plusJakartaSans(
    textStyle: const TextStyle(fontFamilyFallback: ['sans-serif']),
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle bodyXl = GoogleFonts.nunitoSans(
    textStyle: const TextStyle(fontFamilyFallback: ['sans-serif']),
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle labelBold = GoogleFonts.plusJakartaSans(
    textStyle: const TextStyle(fontFamilyFallback: ['sans-serif']),
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
}
