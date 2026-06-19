import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class NumberModel extends Equatable {
  final String id;
  final int value;
  final String spokenName;
  final String? assetImage;
  final String emoji;
  final Color cardColor;
  final String ttsText;
  final int group;

  const NumberModel({
    required this.id,
    required this.value,
    required this.spokenName,
    this.assetImage,
    required this.emoji,
    required this.cardColor,
    required this.ttsText,
    required this.group,
  });

  @override
  List<Object?> get props => [id, value, spokenName, assetImage, emoji, cardColor, ttsText, group];
}
