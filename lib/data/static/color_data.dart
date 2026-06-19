import 'package:flutter/material.dart';
import 'package:abc_wonder/data/models/color_model.dart';

class ColorData {
  static const List<ColorModel> items = [
    ColorModel(id: 'red', name: 'Red', color: Colors.red, gradientStart: Color(0xFFFFB3B3), gradientEnd: Color(0xFFFF4D4D), emoji: '🔴', ttsText: 'Red', isPrimary: true, hexCode: '#FF0000'),
    ColorModel(id: 'blue', name: 'Blue', color: Colors.blue, gradientStart: Color(0xFFB3D9FF), gradientEnd: Color(0xFF4D94FF), emoji: '🔵', ttsText: 'Blue', isPrimary: true, hexCode: '#0000FF'),
    ColorModel(id: 'green', name: 'Green', color: Colors.green, gradientStart: Color(0xFFB3FFB3), gradientEnd: Color(0xFF4DFF4D), emoji: '🟢', ttsText: 'Green', isPrimary: false, hexCode: '#00FF00'),
    ColorModel(id: 'yellow', name: 'Yellow', color: Colors.yellow, gradientStart: Color(0xFFFFF9B3), gradientEnd: Color(0xFFFFF24D), emoji: '🟡', ttsText: 'Yellow', isPrimary: true, hexCode: '#FFFF00'),
    ColorModel(id: 'orange', name: 'Orange', color: Colors.orange, gradientStart: Color(0xFFFFD4B3), gradientEnd: Color(0xFFFF8C4D), emoji: '🟠', ttsText: 'Orange', isPrimary: false, hexCode: '#FFA500'),
    ColorModel(id: 'purple', name: 'Purple', color: Colors.purple, gradientStart: Color(0xFFE6B3FF), gradientEnd: Color(0xFFCC4DFF), emoji: '🟣', ttsText: 'Purple', isPrimary: false, hexCode: '#800080'),
    ColorModel(id: 'pink', name: 'Pink', color: Colors.pink, gradientStart: Color(0xFFFFB3C6), gradientEnd: Color(0xFFFF4D7A), emoji: '🩷', ttsText: 'Pink', isPrimary: false, hexCode: '#FFC0CB'),
    ColorModel(id: 'brown', name: 'Brown', color: Colors.brown, gradientStart: Color(0xFFD4B3A3), gradientEnd: Color(0xFF8C5A3D), emoji: '🟤', ttsText: 'Brown', isPrimary: false, hexCode: '#A52A2A'),
    ColorModel(id: 'black', name: 'Black', color: Colors.black, gradientStart: Color(0xFF666666), gradientEnd: Color(0xFF000000), emoji: '⚫', ttsText: 'Black', isPrimary: false, hexCode: '#000000'),
    ColorModel(id: 'white', name: 'White', color: Colors.white, gradientStart: Color(0xFFFFFFFF), gradientEnd: Color(0xFFE6E6E6), emoji: '⚪', ttsText: 'White', isPrimary: false, hexCode: '#FFFFFF'),
  ];

  static ColorModel? byId(String id) =>
      items.where((e) => e.id == id).firstOrNull;

  static List<ColorModel> get primary =>
      items.where((e) => e.isPrimary).toList();

  static List<ColorModel> get secondary =>
      items.where((e) => !e.isPrimary).toList();
}
