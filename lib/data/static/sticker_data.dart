import 'package:abc_wonder/data/models/sticker_model.dart';

class StickerData {
  static const List<StickerModel> items = [
    StickerModel(id: 's_alphabet_a', name: 'A is for Apple', category: 'Alphabet', emoji: '🍎', unlockCondition: 'Complete letter A', isUnlocked: true, unlockModuleId: 'alphabet', unlockItemId: 'A'),
    StickerModel(id: 's_alphabet_b', name: 'B is for Ball', category: 'Alphabet', emoji: '⚽', unlockCondition: 'Complete letter B', unlockModuleId: 'alphabet', unlockItemId: 'B'),
    StickerModel(id: 's_alphabet_c', name: 'C is for Cat', category: 'Alphabet', emoji: '🐱', unlockCondition: 'Complete letter C', unlockModuleId: 'alphabet', unlockItemId: 'C'),
    StickerModel(id: 's_alphabet_star', name: 'Alphabet Star', category: 'Alphabet', emoji: '⭐', unlockCondition: 'Complete all 26 letters', isUnlocked: true),
    StickerModel(id: 's_number_one', name: 'Number 1', category: 'Numbers', emoji: '1️⃣', unlockCondition: 'Complete number 1', isUnlocked: true, unlockModuleId: 'numbers', unlockItemId: '1'),
    StickerModel(id: 's_number_ten', name: 'Number 10', category: 'Numbers', emoji: '🔟', unlockCondition: 'Complete number 10', unlockModuleId: 'numbers', unlockItemId: '10'),
    StickerModel(id: 's_number_star', name: 'Numbers Star', category: 'Numbers', emoji: '🌟', unlockCondition: 'Finish all numbers'),
    StickerModel(id: 's_color_red', name: 'Red', category: 'Colors', emoji: '🟥', unlockCondition: 'Explore red', isUnlocked: true, unlockModuleId: 'colors', unlockItemId: 'red'),
    StickerModel(id: 's_color_blue', name: 'Blue', category: 'Colors', emoji: '🟦', unlockCondition: 'Explore blue', unlockModuleId: 'colors', unlockItemId: 'blue'),
    StickerModel(id: 's_color_rainbow', name: 'Rainbow', category: 'Colors', emoji: '🌈', unlockCondition: 'Explore all colors'),
    StickerModel(id: 's_shape_circle', name: 'Circle', category: 'Shapes', emoji: '⭕', unlockCondition: 'Learn circle', isUnlocked: true, unlockModuleId: 'shapes', unlockItemId: 'circle'),
    StickerModel(id: 's_shape_square', name: 'Square', category: 'Shapes', emoji: '🟦', unlockCondition: 'Learn square', unlockModuleId: 'shapes', unlockItemId: 'square'),
    StickerModel(id: 's_shape_star', name: 'Star Shape', category: 'Shapes', emoji: '⭐', unlockCondition: 'Learn all shapes'),
    StickerModel(id: 's_day_monday', name: 'Monday', category: 'Days', emoji: '📚', unlockCondition: 'Learn Monday', isUnlocked: true, unlockModuleId: 'days', unlockItemId: 'monday'),
    StickerModel(id: 's_day_sunday', name: 'Sunday Fun', category: 'Days', emoji: '🎉', unlockCondition: 'Learn Sunday', unlockModuleId: 'days', unlockItemId: 'sunday'),
    StickerModel(id: 's_month_jan', name: 'January Snow', category: 'Months', emoji: '❄️', unlockCondition: 'Explore January', isUnlocked: true, unlockModuleId: 'months', unlockItemId: 'january'),
    StickerModel(id: 's_month_dec', name: 'December Joy', category: 'Months', emoji: '🎄', unlockCondition: 'Explore December', unlockModuleId: 'months', unlockItemId: 'december'),
    StickerModel(id: 's_all_explorer', name: 'Little Explorer', category: 'Special', emoji: '🧭', unlockCondition: 'Visit all 6 modules'),
    StickerModel(id: 's_all_champion', name: 'ABC Champion', category: 'Special', emoji: '🏆', unlockCondition: 'Complete all modules'),
  ];

  static List<StickerModel> byCategory(String category) =>
      items.where((s) => s.category == category).toList();

  static List<String> get categories =>
      items.map((s) => s.category).toSet().toList();

  static int get unlockedCount => items.where((s) => s.isUnlocked).length;

  static int get totalCount => items.length;
}
