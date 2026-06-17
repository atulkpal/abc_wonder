# Asset Migration Guide

## When You Want to Add Real Images

The app is designed so you can drop in real illustration assets later without touching any logic.

## File Structure

Place your assets in these directories:

```
assets/
├── images/
│   ├── letters/       # e.g., a_apple.png, b_ball.png
│   ├── numbers/       # e.g., 1.png, 2.png (illustration of quantity)
│   ├── days/          # e.g., monday.png, tuesday.png
│   └── months/        # e.g., january.png, february.png
└── fonts/             # Optional: custom font files
```

## Steps to Add Assets

### 1. Place the files
Put your PNG/SVG/WebP files in the appropriate directory under `assets/images/`.

### 2. Register in pubspec.yaml

```yaml
flutter:
  assets:
    - assets/images/letters/
    - assets/images/numbers/
    - assets/images/days/
    - assets/images/months/
```

### 3. Update the data file

Each data file has an `assetImage` field set to `null`. Change it to the path:

```dart
// Before (alphabet_data.dart)
Letter(character: 'A', name: 'A', example: 'Apple', assetImage: null, ...)

// After
Letter(character: 'A', name: 'A', example: 'Apple', assetImage: 'assets/images/letters/a_apple.png', ...)
```

### 4. Done

The widget already checks: if `assetImage != null`, show the image; otherwise show the emoji/color placeholder.

## How the Fallback Works

In each card widget:

```dart
if (item.assetImage != null) {
  return Image.asset(item.assetImage!);
} else {
  return ColoredBox(color: item.cardColor, child: Text(item.emoji ?? item.character));
}
```

## Removing Emoji Placeholders

Once all assets are in place, you can remove the `emoji` field from models if desired — or keep them as a backup fallback.

## Fonts

To use a custom font (e.g., Fredoka One):

1. Download the `.ttf` files
2. Place in `assets/fonts/`
3. Register in `pubspec.yaml` under `flutter: fonts:`
4. The theme already references `FontFamily.fredokaOne` and `FontFamily.nunito` — update these constants in `app_theme.dart`
