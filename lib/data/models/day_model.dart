import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class DayModel extends Equatable {
  final String id;
  final String name;
  final String shortName;
  final int index;
  final String? assetImage;
  final String emoji;
  final Color cardColor;
  final String ttsText;
  final bool isWeekend;

  const DayModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.index,
    this.assetImage,
    required this.emoji,
    required this.cardColor,
    required this.ttsText,
    required this.isWeekend,
  });

  @override
  List<Object?> get props => [id, name, shortName, index, assetImage, emoji, cardColor, ttsText, isWeekend];
}
