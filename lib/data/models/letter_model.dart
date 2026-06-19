import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class LetterModel extends Equatable {
  final String id;
  final String character;
  final String name;
  final String example;
  final String? assetImage;
  final String emoji;
  final Color cardColor;
  final String ttsText;
  final bool isVowel;
  final int index;

  const LetterModel({
    required this.id,
    required this.character,
    required this.name,
    required this.example,
    this.assetImage,
    required this.emoji,
    required this.cardColor,
    required this.ttsText,
    required this.isVowel,
    required this.index,
  });

  @override
  List<Object?> get props => [id, character, name, example, assetImage, emoji, cardColor, ttsText, isVowel, index];
}
