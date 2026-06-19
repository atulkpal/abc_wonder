import 'package:flutter/material.dart';
import 'package:abc_wonder/data/models/shape_model.dart';

class ShapeData {
  static const List<ShapeModel> items = [
    ShapeModel(id: 'circle', name: 'Circle', emoji: '⭕', ttsText: 'Circle', cardColor: Color(0xFF7AD0FF), sides: 0, hasCorners: false),
    ShapeModel(id: 'square', name: 'Square', emoji: '🟦', ttsText: 'Square', cardColor: Color(0xFF7AD0FF), sides: 4, hasCorners: true),
    ShapeModel(id: 'triangle', name: 'Triangle', emoji: '🔺', ttsText: 'Triangle', cardColor: Color(0xFF7AD0FF), sides: 3, hasCorners: true),
    ShapeModel(id: 'rectangle', name: 'Rectangle', emoji: '▬', ttsText: 'Rectangle', cardColor: Color(0xFF7AD0FF), sides: 4, hasCorners: true),
    ShapeModel(id: 'oval', name: 'Oval', emoji: '🥚', ttsText: 'Oval', cardColor: Color(0xFF7AD0FF), sides: 0, hasCorners: false),
    ShapeModel(id: 'diamond', name: 'Diamond', emoji: '💎', ttsText: 'Diamond', cardColor: Color(0xFF7AD0FF), sides: 4, hasCorners: true),
    ShapeModel(id: 'heart', name: 'Heart', emoji: '❤️', ttsText: 'Heart', cardColor: Color(0xFF7AD0FF), sides: 0, hasCorners: false),
    ShapeModel(id: 'star', name: 'Star', emoji: '⭐', ttsText: 'Star', cardColor: Color(0xFF7AD0FF), sides: 10, hasCorners: true),
  ];

  static ShapeModel? byId(String id) =>
      items.where((e) => e.id == id).firstOrNull;
}
