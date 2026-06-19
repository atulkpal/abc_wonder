import 'package:flutter/material.dart';
import 'package:abc_wonder/data/models/month_model.dart';

class MonthsData {
  static const List<MonthModel> items = [
    MonthModel(id: 'january', name: 'January', shortName: 'Jan', index: 1, emoji: '❄️', ttsText: 'January', cardColor: Color(0xFFA78BFA), season: 'winter', seasonGradientStart: Color(0xFFF5FAFF), seasonGradientEnd: Color(0xFFC3E8FF)),
    MonthModel(id: 'february', name: 'February', shortName: 'Feb', index: 2, emoji: '💝', ttsText: 'February', cardColor: Color(0xFFA78BFA), season: 'winter', seasonGradientStart: Color(0xFFFFD9DF), seasonGradientEnd: Color(0xFFFF9BB2)),
    MonthModel(id: 'march', name: 'March', shortName: 'Mar', index: 3, emoji: '🌸', ttsText: 'March', cardColor: Color(0xFFA78BFA), season: 'spring', seasonGradientStart: Color(0xFFEAFAD1), seasonGradientEnd: Color(0xFFB3E57C)),
    MonthModel(id: 'april', name: 'April', shortName: 'Apr', index: 4, emoji: '🌧️', ttsText: 'April', cardColor: Color(0xFFA78BFA), season: 'spring', seasonGradientStart: Color(0xFFD4E6F1), seasonGradientEnd: Color(0xFF85C1E9)),
    MonthModel(id: 'may', name: 'May', shortName: 'May', index: 5, emoji: '🌺', ttsText: 'May', cardColor: Color(0xFFA78BFA), season: 'spring', seasonGradientStart: Color(0xFFFFE0B3), seasonGradientEnd: Color(0xFFFFB366)),
    MonthModel(id: 'june', name: 'June', shortName: 'Jun', index: 6, emoji: '☀️', ttsText: 'June', cardColor: Color(0xFFA78BFA), season: 'summer', seasonGradientStart: Color(0xFFFFF3B3), seasonGradientEnd: Color(0xFFFFE64D)),
    MonthModel(id: 'july', name: 'July', shortName: 'Jul', index: 7, emoji: '🏖️', ttsText: 'July', cardColor: Color(0xFFA78BFA), season: 'summer', seasonGradientStart: Color(0xFFB3E0FF), seasonGradientEnd: Color(0xFF4DB8FF)),
    MonthModel(id: 'august', name: 'August', shortName: 'Aug', index: 8, emoji: '🌻', ttsText: 'August', cardColor: Color(0xFFA78BFA), season: 'summer', seasonGradientStart: Color(0xFFD4F5D4), seasonGradientEnd: Color(0xFF7AE07A)),
    MonthModel(id: 'september', name: 'September', shortName: 'Sep', index: 9, emoji: '🍁', ttsText: 'September', cardColor: Color(0xFFA78BFA), season: 'fall', seasonGradientStart: Color(0xFFFFD4B3), seasonGradientEnd: Color(0xFFFF8C4D)),
    MonthModel(id: 'october', name: 'October', shortName: 'Oct', index: 10, emoji: '🎃', ttsText: 'October', cardColor: Color(0xFFA78BFA), season: 'fall', seasonGradientStart: Color(0xFFE6B3FF), seasonGradientEnd: Color(0xFFCC4DFF)),
    MonthModel(id: 'november', name: 'November', shortName: 'Nov', index: 11, emoji: '🦃', ttsText: 'November', cardColor: Color(0xFFA78BFA), season: 'fall', seasonGradientStart: Color(0xFFD4A373), seasonGradientEnd: Color(0xFF8C5A3D)),
    MonthModel(id: 'december', name: 'December', shortName: 'Dec', index: 12, emoji: '🎄', ttsText: 'December', cardColor: Color(0xFFA78BFA), season: 'winter', seasonGradientStart: Color(0xFFD4F5D4), seasonGradientEnd: Color(0xFF4DCC4D)),
  ];

  static MonthModel? byId(String id) =>
      items.where((e) => e.id == id).firstOrNull;

  static List<MonthModel> bySeason(String season) =>
      items.where((e) => e.season == season).toList();
}
