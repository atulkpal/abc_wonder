import 'package:flutter/material.dart';
import 'package:abc_wonder/data/models/letter_model.dart';

class AlphabetData {
  static const List<LetterModel> items = [
    LetterModel(id: 'A', character: 'A', name: 'A', example: 'Apple', emoji: '🍎', ttsText: 'A for Apple', cardColor: Color(0xFFFF6B6B), isVowel: true, index: 0),
    LetterModel(id: 'B', character: 'B', name: 'B', example: 'Ball', emoji: '⚽', ttsText: 'B for Ball', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 1),
    LetterModel(id: 'C', character: 'C', name: 'C', example: 'Cat', emoji: '🐱', ttsText: 'C for Cat', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 2),
    LetterModel(id: 'D', character: 'D', name: 'D', example: 'Dog', emoji: '🐶', ttsText: 'D for Dog', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 3),
    LetterModel(id: 'E', character: 'E', name: 'E', example: 'Elephant', emoji: '🐘', ttsText: 'E for Elephant', cardColor: Color(0xFFFF6B6B), isVowel: true, index: 4),
    LetterModel(id: 'F', character: 'F', name: 'F', example: 'Fish', emoji: '🐟', ttsText: 'F for Fish', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 5),
    LetterModel(id: 'G', character: 'G', name: 'G', example: 'Goat', emoji: '🐐', ttsText: 'G for Goat', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 6),
    LetterModel(id: 'H', character: 'H', name: 'H', example: 'Hen', emoji: '🐔', ttsText: 'H for Hen', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 7),
    LetterModel(id: 'I', character: 'I', name: 'I', example: 'Ice cream', emoji: '🍦', ttsText: 'I for Ice cream', cardColor: Color(0xFFFF6B6B), isVowel: true, index: 8),
    LetterModel(id: 'J', character: 'J', name: 'J', example: 'Jug', emoji: '🏺', ttsText: 'J for Jug', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 9),
    LetterModel(id: 'K', character: 'K', name: 'K', example: 'Kite', emoji: '🪁', ttsText: 'K for Kite', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 10),
    LetterModel(id: 'L', character: 'L', name: 'L', example: 'Lion', emoji: '🦁', ttsText: 'L for Lion', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 11),
    LetterModel(id: 'M', character: 'M', name: 'M', example: 'Monkey', emoji: '🐵', ttsText: 'M for Monkey', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 12),
    LetterModel(id: 'N', character: 'N', name: 'N', example: 'Nest', emoji: '🪺', ttsText: 'N for Nest', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 13),
    LetterModel(id: 'O', character: 'O', name: 'O', example: 'Orange', emoji: '🍊', ttsText: 'O for Orange', cardColor: Color(0xFFFF6B6B), isVowel: true, index: 14),
    LetterModel(id: 'P', character: 'P', name: 'P', example: 'Parrot', emoji: '🦜', ttsText: 'P for Parrot', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 15),
    LetterModel(id: 'Q', character: 'Q', name: 'Q', example: 'Queen', emoji: '👑', ttsText: 'Q for Queen', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 16),
    LetterModel(id: 'R', character: 'R', name: 'R', example: 'Rabbit', emoji: '🐰', ttsText: 'R for Rabbit', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 17),
    LetterModel(id: 'S', character: 'S', name: 'S', example: 'Ship', emoji: '🚢', ttsText: 'S for Ship', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 18),
    LetterModel(id: 'T', character: 'T', name: 'T', example: 'Tiger', emoji: '🐯', ttsText: 'T for Tiger', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 19),
    LetterModel(id: 'U', character: 'U', name: 'U', example: 'Umbrella', emoji: '☂️', ttsText: 'U for Umbrella', cardColor: Color(0xFFFF6B6B), isVowel: true, index: 20),
    LetterModel(id: 'V', character: 'V', name: 'V', example: 'Violin', emoji: '🎻', ttsText: 'V for Violin', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 21),
    LetterModel(id: 'W', character: 'W', name: 'W', example: 'Watch', emoji: '⌚', ttsText: 'W for Watch', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 22),
    LetterModel(id: 'X', character: 'X', name: 'X', example: 'Xylophone', emoji: '🎵', ttsText: 'X for Xylophone', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 23),
    LetterModel(id: 'Y', character: 'Y', name: 'Y', example: 'Yak', emoji: '🐃', ttsText: 'Y for Yak', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 24),
    LetterModel(id: 'Z', character: 'Z', name: 'Z', example: 'Zebra', emoji: '🦓', ttsText: 'Z for Zebra', cardColor: Color(0xFFFF6B6B), isVowel: false, index: 25),
  ];

  static LetterModel? byId(String id) =>
      items.where((e) => e.id == id).firstOrNull;

  static List<LetterModel> get vowels =>
      items.where((e) => e.isVowel).toList();

  static List<LetterModel> get consonants =>
      items.where((e) => !e.isVowel).toList();
}
