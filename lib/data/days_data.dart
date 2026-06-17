import 'package:abc_wonder/models/item_model.dart';
import 'package:abc_wonder/theme/app_theme.dart';

class DaysData {
  static const List<ItemModel> items = [
    ItemModel(title: 'Sunday', subtitle: 'Sun', emoji: '🌞', ttsText: 'Sunday', color: AppTheme.daysColor),
    ItemModel(title: 'Monday', subtitle: 'Mon', emoji: '📚', ttsText: 'Monday', color: AppTheme.daysColor),
    ItemModel(title: 'Tuesday', subtitle: 'Tue', emoji: '🎨', ttsText: 'Tuesday', color: AppTheme.daysColor),
    ItemModel(title: 'Wednesday', subtitle: 'Wed', emoji: '🌈', ttsText: 'Wednesday', color: AppTheme.daysColor),
    ItemModel(title: 'Thursday', subtitle: 'Thu', emoji: '🎮', ttsText: 'Thursday', color: AppTheme.daysColor),
    ItemModel(title: 'Friday', subtitle: 'Fri', emoji: '🎉', ttsText: 'Friday', color: AppTheme.daysColor),
    ItemModel(title: 'Saturday', subtitle: 'Sat', emoji: '⚽', ttsText: 'Saturday', color: AppTheme.daysColor),
  ];
}
