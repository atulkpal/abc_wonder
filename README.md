<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://placehold.co/120x120/FF6B6B/FFFFFF?text=ABC&font=montserrat">
  <img align="right" width="120" height="120" src="https://placehold.co/120x120/FF6B6B/FFFFFF?text=ABC&font=montserrat" alt="ABC Wonder logo">
</picture>

# ABC Wonder

**Learn & Play, One Step a Day**  

A colourful, non-addictive learning app for children aged 2–6. No ads, no autoplay, no rewards — just a gentle space to explore letters, numbers, days, and months at their own pace.

---

## Features

- **Swipe & Learn** — Full-screen page carousel for each category: Alphabet (A–Z), Numbers (1–100), Days of the week, Months of the year
- **Text-to-Speech** — Each item is read aloud automatically on page change, and re-reads when tapped
- **Smart Navigation** — Chevron arrows + adaptive dot indicator (max 7 dots for small categories, "N of M" counter for large ones)
- **Tactile Feedback** — Gentle scale animation (0.92) on tap
- **Gradient Backgrounds** — Distinct colour palette per category to aid visual recognition
- **Responsive** — Adapts to phones and tablets (600dp+ breakpoint)
- **Playful Illustrations** — Emoji placeholders for every item (swap to custom assets via the `assetImage` field)

## Design Principles

| Principle | Detail |
|-----------|--------|
| 🚫 No ads | Zero advertising, tracking, or data collection |
| 🔇 No autoplay | The child controls progression, not the app |
| 🎁 No rewards | No points, stars, or gamification — intrinsic joy of discovery |
| 🔊 Audio-first | TTS instead of pre-recorded audio (smaller APK, localised out of the box) |

## Tech Stack

| Layer | Choice |
|-------|--------|
| Framework | Flutter 3.44.2 / Dart 3.12.2 |
| Navigation | `MaterialApp` routes + `Navigator.push` |
| Audio | `flutter_tts` 4.2.2 (TTS, rate 0.4, pitch 1.1) |
| Layout | `MediaQuery` + `LayoutBuilder` (no screen scaling packages) |
| Target | Android API 21+ / iOS 13+ |

## Architecture

```
lib/
├── main.dart                  # Entrypoint
├── app.dart                   # MaterialApp with splash → home routes
├── models/
│   └── item_model.dart        # Unified ItemModel
├── data/
│   ├── alphabet_data.dart     # 26 items
│   ├── number_data.dart       # 100 items (1–100)
│   ├── days_data.dart         # 7 items
│   └── months_data.dart       # 12 items
├── screens/
│   ├── splash_screen.dart     # 2-second animated splash
│   ├── home_screen.dart       # 2×2 category grid (responsive)
│   └── detail_screen.dart     # PageView carousel + TTS + navigation
├── widgets/
│   └── category_tile.dart     # Gradient tile with emoji
├── theme/
│   └── app_theme.dart         # Colour constants, ThemeData
└── utils/
    └── tts_helper.dart        # TtsHelper singleton
```

## Getting Started

### Prerequisites

- Flutter 3.44.2+ ([install guide](https://docs.flutter.dev/get-started/install))
- Android SDK (API 21+) — set `ANDROID_HOME`
- Java 17+ — set `JAVA_HOME`
- Windows Developer Mode (for plugin symlinks on Windows)

### Install & Run

```bash
flutter pub get
flutter run
```

### On a running emulator

```bash
flutter run -d emulator-5554
```

### Build Release APK

```bash
flutter build apk --release --split-per-abi
```

Output (3 ABIs, ~12–16 MB each):

```
build/app/outputs/flutter-apk/
├── app-armeabi-v7a-release.apk
├── app-arm64-v8a-release.apk
└── app-x86_64-release.apk
```

## Customisation

### Adding new items

Edit the static list in the corresponding data file (`lib/data/`). Each item follows the `ItemModel` shape:

```dart
ItemModel(
  title: 'A',                    // Display text (large)
  subtitle: 'Apple',             // Display text (small)
  emoji: '🍎',                   // Emoji / asset placeholder
  ttsText: 'A for Apple',        // What TTS reads aloud
  color: AppTheme.alphabetColor, // Gradient base colour
)
```

### Replacing emoji with real assets

Each `ItemModel` has an optional `assetImage` field. When set, the detail screen renders the asset instead of the emoji. See `docs/asset_migration_guide.md`.

## Known Issues

- `flutter_tts` 4.2.2 applies Kotlin Gradle Plugin — a future Flutter version may require migration to Built-in Kotlin
- AppTheme2 is duplicated in `detail_screen.dart` (local helper, not imported from `app_theme.dart`)
- Assets directory exists but is empty (emoji strategy for now)

## Roadmap

- [ ] Custom fonts (Fredoka One)
- [ ] Real illustrations replacing emoji placeholders
- [ ] iOS release build
- [ ] Tablet-optimised landscape layout

## License

```
MIT License

Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
