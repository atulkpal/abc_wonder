import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class ColorModel extends Equatable {
  final String id;
  final String name;
  final Color color;
  final Color gradientStart;
  final Color gradientEnd;
  final String? assetImage;
  final String emoji;
  final String ttsText;
  final bool isPrimary;
  final String hexCode;

  const ColorModel({
    required this.id,
    required this.name,
    required this.color,
    required this.gradientStart,
    required this.gradientEnd,
    this.assetImage,
    required this.emoji,
    required this.ttsText,
    required this.isPrimary,
    required this.hexCode,
  });

  @override
  List<Object?> get props => [id, name, color, gradientStart, gradientEnd, assetImage, emoji, ttsText, isPrimary, hexCode];
}
