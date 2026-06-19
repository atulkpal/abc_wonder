import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class ShapeModel extends Equatable {
  final String id;
  final String name;
  final String? assetImage;
  final String emoji;
  final Color cardColor;
  final String ttsText;
  final int sides;
  final String? svgPath;
  final bool hasCorners;

  const ShapeModel({
    required this.id,
    required this.name,
    this.assetImage,
    required this.emoji,
    required this.cardColor,
    required this.ttsText,
    required this.sides,
    this.svgPath,
    required this.hasCorners,
  });

  @override
  List<Object?> get props => [id, name, assetImage, emoji, cardColor, ttsText, sides, svgPath, hasCorners];
}
