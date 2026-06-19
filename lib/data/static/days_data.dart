import 'package:flutter/material.dart';
import 'package:abc_wonder/data/models/day_model.dart';

class DaysData {
  static const List<DayModel> items = [
    DayModel(id: 'sunday', name: 'Sunday', shortName: 'Sun', index: 7, emoji: '🌞', ttsText: 'Sunday', cardColor: Color(0xFFFFE66D), isWeekend: true),
    DayModel(id: 'monday', name: 'Monday', shortName: 'Mon', index: 1, emoji: '📚', ttsText: 'Monday', cardColor: Color(0xFFFFE66D), isWeekend: false),
    DayModel(id: 'tuesday', name: 'Tuesday', shortName: 'Tue', index: 2, emoji: '🎨', ttsText: 'Tuesday', cardColor: Color(0xFFFFE66D), isWeekend: false),
    DayModel(id: 'wednesday', name: 'Wednesday', shortName: 'Wed', index: 3, emoji: '🌈', ttsText: 'Wednesday', cardColor: Color(0xFFFFE66D), isWeekend: false),
    DayModel(id: 'thursday', name: 'Thursday', shortName: 'Thu', index: 4, emoji: '🎮', ttsText: 'Thursday', cardColor: Color(0xFFFFE66D), isWeekend: false),
    DayModel(id: 'friday', name: 'Friday', shortName: 'Fri', index: 5, emoji: '🎉', ttsText: 'Friday', cardColor: Color(0xFFFFE66D), isWeekend: false),
    DayModel(id: 'saturday', name: 'Saturday', shortName: 'Sat', index: 6, emoji: '⚽', ttsText: 'Saturday', cardColor: Color(0xFFFFE66D), isWeekend: true),
  ];

  static DayModel? byId(String id) =>
      items.where((e) => e.id == id).firstOrNull;

  static List<DayModel> get weekdays =>
      items.where((e) => !e.isWeekend).toList();

  static List<DayModel> get weekends =>
      items.where((e) => e.isWeekend).toList();
}
