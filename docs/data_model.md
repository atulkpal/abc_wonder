# Data Models

## Letter

```dart
class Letter {
  final String character;   // "A"
  final String name;        // "A"
  final String example;     // "Apple"
  final String? assetImage; // null → emoji/color fallback until assets added
  final Color cardColor;    // coral variant for alphabet
  final String ttsText;     // "A for Apple" — what TTS speaks
}
```

## Number

```dart
class Number {
  final int value;           // 3
  final String spokenName;   // "Three"
  final String ttsText;      // "Three" — what TTS speaks
  final String? assetImage;  // null → emoji fallback
  final String emoji;        // "🐶" for counting display
}
```

## Day

```dart
class Day {
  final String name;         // "Monday"
  final String shortName;    // "Mon"
  final int index;           // 1 (Monday = 1)
  final String emoji;        // "📚"
  final String ttsText;      // "Monday"
}
```

## Month

```dart
class Month {
  final String name;         // "January"
  final String shortName;    // "Jan"
  final int index;           // 1
  final String emoji;        // "❄️"
  final String ttsText;      // "January"
}
```

## Future Asset Migration

All models have an optional `assetImage` field. When `null`, the UI shows:
- **Letters**: A colored circle with the character in white
- **Numbers**: A colored circle with the number + emoji objects
- **Days**: A colored card with the emoji
- **Months**: A colored card with the emoji

To add real assets later, simply:
1. Place PNG/SVG files in `assets/images/{category}/`
2. Update the data file's `assetImage` field with the asset path
3. Update `pubspec.yaml` to include the asset
4. The widget already handles the `null` → placeholder fallback
