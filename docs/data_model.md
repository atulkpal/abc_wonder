# ABC Wonder — Data Models

This document defines all domain models for the ABC Wonder learning platform. Current code has a single `ItemModel` — these models replace it with domain-specific types.

---

## 1. Learning Module Models

### LetterModel
```dart
class LetterModel {
  final String id;           // "A", "B", ...
  final String character;    // "A"
  final String name;         // "A"
  final String example;      // "Apple"
  final String? assetImage;  // "assets/images/letters/a.png" (null → emoji fallback)
  final String emoji;        // "🍎"
  final Color cardColor;     // Color(0xFFFF6B6B) (alphabetColor)
  final String ttsText;      // "A for Apple"
  final bool isVowel;        // true for A, E, I, O, U
  final int index;           // 0-25
}
```

### NumberModel
```dart
class NumberModel {
  final String id;           // "1", "2", ...
  final int value;           // 1, 2, ... 100
  final String spokenName;   // "One", "Two", ...
  final String? assetImage;  // "assets/images/numbers/1.png"
  final String emoji;        // "🐶"
  final Color cardColor;     // Color(0xFF4ECDC4) (numberColor)
  final String ttsText;      // "One"
  final int group;           // 0 (1-10), 1 (11-20), ... 9 (91-100)
}
```

### ColorModel
```dart
class ColorModel {
  final String id;           // "red", "blue", ...
  final String name;         // "Red"
  final Color color;         // Actual color value
  final Color gradientStart; // Start of detail screen gradient
  final Color gradientEnd;   // End of detail screen gradient
  final String? assetImage;  // "assets/images/colors/red.png"
  final String emoji;        // "🔴"
  final String ttsText;      // "Red"
  final bool isPrimary;      // true for red/blue/yellow
  final String hexCode;      // "#FF0000"
}
```

### ShapeModel
```dart
class ShapeModel {
  final String id;           // "circle", "square", ...
  final String name;         // "Circle"
  final String? assetImage;  // "assets/images/shapes/circle.png"
  final String emoji;        // "⭕"
  final Color cardColor;     // Primary blue or module color
  final String ttsText;      // "Circle"
  final int sides;           // 0 (circle/oval), 3 (triangle), 4 (square/rectangle/diamond), ...
  final String svgPath;      // "assets/images/shapes/circle.svg" or similar
  final bool hasCorners;     // false for circle/oval, true for others
}
```

### DayModel
```dart
class DayModel {
  final String id;           // "monday", "tuesday", ...
  final String name;         // "Monday"
  final String shortName;    // "Mon"
  final int index;           // 1 (Monday) - 7 (Sunday)
  final String? assetImage;  // "assets/images/days/monday.png"
  final String emoji;        // "📚"
  final Color cardColor;     // Color(0xFFFFE66D) (daysColor)
  final String ttsText;      // "Monday"
  final bool isWeekend;      // true for Saturday, Sunday
}
```

### MonthModel
```dart
class MonthModel {
  final String id;           // "january", "february", ...
  final String name;         // "January"
  final String shortName;    // "Jan"
  final int index;           // 1 (January) - 12 (December)
  final String? assetImage;  // "assets/images/months/january.png"
  final String emoji;        // "❄️"
  final Color cardColor;     // Color(0xFFA78BFA) (monthsColor)
  final String ttsText;      // "January"
  final String season;       // "winter", "spring", "summer", "fall"
  final Color seasonGradientStart;  // Seasonal gradient for detail screen
  final Color seasonGradientEnd;
}
```

---

## 2. Progress & Reward Models

### ProgressModel
```dart
class ProgressModel {
  final String moduleId;        // "alphabet", "numbers", "colors", "shapes", "days", "months"
  final Map<String, bool> completedItems;  // {"A": true, "B": false, ...}
  final int totalItems;
  final int completedCount;
  final DateTime? lastPlayedDate;
  final int sessionCount;
  final Duration totalTimeSpent;
  final double averageAccuracy;  // 0.0 - 1.0

  double get completionPercentage => completedCount / totalItems;
  bool get isModuleComplete => completedCount >= totalItems;
}
```

### StickerModel
```dart
class StickerModel {
  final String id;              // "sticker_alphabet_a", ...
  final String name;            // "Apple"
  final String category;        // "alphabet", "numbers", "colors", "shapes", "days", "months"
  final String? imagePath;      // "assets/images/stickers/apple.png" (null → emoji fallback)
  final String emoji;           // "🍎"
  final String unlockCondition; // "Complete letter A"
  final bool isUnlocked;        // persisted state
  final bool isFavorite;        // user can favorite stickers
  final String? unlockModuleId; // Which module triggers this
  final String? unlockItemId;   // Which item triggers this
}
```

### AchievementModel
```dart
enum AchievementTier { bronze, silver, gold, platinum }

class AchievementModel {
  final String id;              // "achievement_first_letter", ...
  final String title;           // "First Letter!"
  final String description;     // "Completed your first letter lesson"
  final AchievementTier tier;
  final String? badgeImagePath; // null → use gradient rendering
  final Color badgeColor;       // metallic gold/silver or gem color
  final String unlockCriteria;  // "alphabet:completed_count >= 1"
  final double progress;        // 0.0 - 1.0 (for progress bar display)
  final bool isUnlocked;        // persisted state
  final DateTime? unlockedDate;
  final int starReward;         // Stars earned on unlock (e.g., 50)
}
```

### RewardModel
```dart
class RewardModel {
  final String id;
  final RewardType type;        // sticker, achievement, treasure, star
  final String name;
  final String description;
  final String? animationAsset; // Lottie/Rive animation path
  final bool isClaimed;
}
```

### StarModel
```dart
class StarModel {
  final String id;
  final int amount;             // 0 - 9999+
  final DateTime earnedDate;
  final String source;          // "alphabet_a", "daily_surprise", ...
  final String sourceDescription;
}
```

---

## 3. User & Settings Models

### UserModel
```dart
class UserModel {
  final String id;
  final String? childName;
  final DateTime? dateOfBirth;
  final String? avatarId;       // avatar_creation screen selection
  final Map<String, ProgressModel> moduleProgress; // per-module progress
  final List<StickerModel> stickers;
  final List<AchievementModel> achievements;
  final int totalStars;
  final int currentStreak;      // consecutive days played
  final int longestStreak;
  final DateTime? lastPlayedDate;
}
```

### RobotModel
```dart
class RobotModel {
  final String id;
  final Color bodyColor;        // Primary robot color
  final Color eyeColor;         // Eye/face display color
  final Color antennaColor;     // Antenna color
  final String? accessoryId;    // "hat", "bowtie", "glasses", etc.
  final String currentExpression; // "happy", "waving", "celebrating", "idle"
}
```

### SettingsModel
```dart
class SettingsModel {
  final double ttsRate;         // 0.4 (default, child-friendly slow)
  final double ttsPitch;        // 1.1
  final String language;        // "en-US"
  final int dailyTimeLimitMinutes;  // 30
  final bool soundEffectsEnabled;   // true
  final bool darkMode;          // false
  final String theme;           // "light"
}
```

---

## 4. Static Data Structure

All learning content is compile-time constants organized by module:

```
lib/data/static/
├── alphabet_data.dart     → List<LetterModel> (26 items)
├── number_data.dart       → List<NumberModel> (100 items)
├── color_data.dart        → List<ColorModel> (11 items)
├── shape_data.dart        → List<ShapeModel> (8+ items)
├── days_data.dart         → List<DayModel> (7 items)
└── months_data.dart       → List<MonthModel> (12 items)
```

Each data file follows this pattern:
```dart
class AlphabetData {
  static const List<LetterModel> items = [
    LetterModel(
      id: 'A',
      character: 'A',
      name: 'A',
      example: 'Apple',
      assetImage: null,
      emoji: '🍎',
      cardColor: AppTheme.alphabetColor,
      ttsText: 'A for Apple',
      isVowel: true,
      index: 0,
    ),
    // ...
  ];

  static LetterModel? byId(String id) =>
      items.where((e) => e.id == id).firstOrNull;

  static List<LetterModel> get vowels =>
      items.where((e) => e.isVowel).toList();

  static List<LetterModel> get consonants =>
      items.where((e) => !e.isVowel).toList();
}
```

---

## 5. Persistence Layer (Hive Boxes)

| Box Name | Key Type | Value Type | Purpose |
|----------|----------|------------|---------|
| `progress_box` | `String` (moduleId) | `ProgressModel` | Per-module completion state |
| `sticker_box` | `String` (stickerId) | `StickerModel` | Sticker unlock/favorite state |
| `achievement_box` | `String` (achievementId) | `AchievementModel` | Achievement progress |
| `settings_box` | `String` (key) | dynamic | User preferences |
| `robot_box` | `String` (field) | dynamic | Robot customization state |
| `star_box` | `String` (id) | `StarModel` | Star ledger entries |

---

## 6. Migration from Current ItemModel

Current data files use a single `ItemModel` with: `title`, `subtitle`, `emoji`, `color`, `ttsText`.

Migration mapping:

| Current ItemModel Field | → LetterModel | → NumberModel | → DayModel | → MonthModel |
|------------------------|---------------|---------------|------------|--------------|
| `title` | `name` / `character` | `spokenName` | `name` | `name` |
| `subtitle` | `example` | — | `shortName` | `shortName` |
| `emoji` | `emoji` | `emoji` | `emoji` | `emoji` |
| `color` | `cardColor` | `cardColor` | `cardColor` | `cardColor` |
| `ttsText` | `ttsText` | `ttsText` | `ttsText` | `ttsText` |
| *(new)* | `id`, `isVowel`, `index` | `id`, `value`, `group` | `id`, `index`, `isWeekend` | `id`, `index`, `season` |

**Note:** The README mentions an `assetImage` field on `ItemModel`. The current code does NOT have this field. The migration should add `assetImage` to the new domain models as an `String?` field defaulting to `null`.
