import 'package:flutter/material.dart';

class ItemModel {
  final String title;
  final String subtitle;
  final String emoji;
  final Color color;
  final String ttsText;

  const ItemModel({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
    required this.ttsText,
  });
}
