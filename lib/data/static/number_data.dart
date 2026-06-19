import 'package:flutter/material.dart';
import 'package:abc_wonder/data/models/number_model.dart';

class NumberData {
  static const List<NumberModel> items = [
    NumberModel(id: '1', value: 1, spokenName: 'One', emoji: '🐶', ttsText: 'One', cardColor: Color(0xFF4ECDC4), group: 0),
    NumberModel(id: '2', value: 2, spokenName: 'Two', emoji: '🐱', ttsText: 'Two', cardColor: Color(0xFF4ECDC4), group: 0),
    NumberModel(id: '3', value: 3, spokenName: 'Three', emoji: '🐭', ttsText: 'Three', cardColor: Color(0xFF4ECDC4), group: 0),
    NumberModel(id: '4', value: 4, spokenName: 'Four', emoji: '🐹', ttsText: 'Four', cardColor: Color(0xFF4ECDC4), group: 0),
    NumberModel(id: '5', value: 5, spokenName: 'Five', emoji: '🐰', ttsText: 'Five', cardColor: Color(0xFF4ECDC4), group: 0),
    NumberModel(id: '6', value: 6, spokenName: 'Six', emoji: '🦊', ttsText: 'Six', cardColor: Color(0xFF4ECDC4), group: 0),
    NumberModel(id: '7', value: 7, spokenName: 'Seven', emoji: '🐻', ttsText: 'Seven', cardColor: Color(0xFF4ECDC4), group: 0),
    NumberModel(id: '8', value: 8, spokenName: 'Eight', emoji: '🐼', ttsText: 'Eight', cardColor: Color(0xFF4ECDC4), group: 0),
    NumberModel(id: '9', value: 9, spokenName: 'Nine', emoji: '🐨', ttsText: 'Nine', cardColor: Color(0xFF4ECDC4), group: 0),
    NumberModel(id: '10', value: 10, spokenName: 'Ten', emoji: '🦁', ttsText: 'Ten', cardColor: Color(0xFF4ECDC4), group: 0),
  ];

  static NumberModel? byId(String id) =>
      items.where((e) => e.id == id).firstOrNull;

  static List<NumberModel> byGroup(int group) =>
      items.where((e) => e.group == group).toList();
}
