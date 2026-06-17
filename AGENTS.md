# ABC Wonder — Agent Guide

## Setup
- Flutter 3.44.2, Dart 3.12.2
- `ANDROID_HOME` = `$env:LOCALAPPDATA\Android\Sdk`
- `JAVA_HOME` = `C:\Program Files\Android\Android Studio\jbr`
- Windows Developer Mode required for plugin builds (symlinks)
- Emulator AVD name: `Medium_Phone`

## Commands
- `flutter pub get` — install deps
- `flutter analyze` — lint + typecheck (run before every commit)
- `flutter test` — widget smoke tests
- `flutter run -d emulator-5554` — run on running emulator
- `flutter build apk --release --split-per-abi` — release APK (3 ABIs, ~15MB each)

## Architecture
- Entrypoint: `lib/main.dart` → `lib/app.dart` (MaterialApp, 2 routes: `/` splash, `/home`)
- Models: single `ItemModel` in `lib/models/item_model.dart`
- Data: static lists in `lib/data/` (alphabet_data, number_data, etc.)
- TTS: singleton `TtsHelper` in `lib/utils/` (rate 0.4, pitch 1.1, en-US)
- Theme: `lib/theme/app_theme.dart` (single `ThemeData`, no custom fonts yet)

## Design Constants
| Role | Hex |
|---|---|
| Background | `#FFF8E7` |
| Alphabet | `#FF6B6B` |
| Numbers | `#4ECDC4` |
| Days | `#FFE66D` |
| Months | `#A78BFA` |
| Text | `#2D3436` |

## App Identity
- Package: `com.abcwonder.abc_wonder`, name: `abc_wonder`
- Min SDK: Android API 21, iOS 13
- Target audience: 2–6 year olds, non-addictive (no autoplay, no rewards, no ads)

## Current State (shipped)
- flutter_screenutil was removed (caused over-scaling on tall screen emulators)
- Layout uses hardcoded dp values + MediaQuery/LayoutBuilder for responsiveness
- PageView swipeable carousel per category (Alphabet 26, Numbers 100, Days 7, Months 12)
- Smart dot indicator (max 7 dots) for categories with ≤30 items; "N of M" counter for >30
- Tap scale animation (0.92) on item tap for tactile feedback
- TTS reads item on page change and re-reads on tap
- Gradient backgrounds per category, emoji placeholders for illustrations
- `flutter analyze` — 0 issues; release APKs built (3 ABIs, ~12-16MB each)
- No custom fonts — using system fonts only

## Known Gotchas
- `flutter_tts` v4.2.2 applies Kotlin Gradle Plugin — warning about future incompatibility
- Emulator screen is 1080×2400 (20:9 tall), test on 600dp+ for tablet layout too
- Assets directory exists but empty (placeholder emoji strategy for now)
- AppTheme2 class duplicated in detail_screen.dart (local helper, not imported from app_theme)
