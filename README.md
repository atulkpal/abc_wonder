# ABC Wonder

**Learn & Play, One Step a Day**

A colourful, non-addictive learning app for children aged 2–6. No ads, no autoplay — just a gentle space to explore letters, numbers, colours, shapes, days, and months at their own pace.

## Features

- **6 Learning Modules** — Alphabet (A–Z), Numbers (1–10), Colours (10), Shapes (8), Days (7), Months (12)
- **Text-to-Speech** — Each item is read aloud on tap (rate 0.4, pitch 1.1, en-US)
- **Interactive Games** — Counting game, multiple-choice quiz per module, matching, puzzles, and more
- **Rewards System** — Sticker museum, achievement badges, treasure chest, hall of champions
- **Parent Dashboard** — Weekly activity charts, per-module progress, TTS/sound settings, parent gate
- **Robot Lab** — Customise robot colour, eyes, and accessories with live preview
- **Responsive** — Adapts to phones and tablets (600dp+ breakpoint)
- **Emoji placeholders** — Swap to custom assets later via `assetImage` field

## Tech Stack

| Layer | Choice |
|-------|--------|
| Framework | Flutter 3.44.2 / Dart 3.12.2 |
| Navigation | GoRouter (30+ named + parameterized routes) |
| State | Riverpod (`ProviderContainer` + `UncontrolledProviderScope`) |
| Audio | `flutter_tts` 4.2.2 |
| Charts | `fl_chart` 0.70.2 |
| Fonts | Google Fonts (Plus Jakarta Sans, Nunito Sans) |
| Layout | `MediaQuery` + `LayoutBuilder` (no screen scaling packages) |
| Target | Android API 21+ / iOS 13+ |

## Architecture

```
lib/
├── main.dart                         # Entrypoint (ProviderContainer → bootstrap → runApp)
├── app.dart                          # MaterialApp.router
├── bootstrap/
│   ├── app_bootstrap.dart            # Init chain: TTS → Monetization → ready
│   └── router.dart                   # GoRouter with all routes
├── core/
│   ├── constants/app_constants.dart  # AppConstants.appName, ttsRate, etc.
│   ├── gradients/                    # 4 gradient widgets
│   ├── monetization/                 # Abstract ad/IAP service + dev/prod impls + parent gate
│   ├── theme/                        # AppColors (50+), AppTypography (5 presets), AppDimensions
│   └── widgets/                      # 14 core widgets (Pressable3D, RimCard, etc.)
├── data/
│   ├── local/                        # Hive box stubs (not yet wired)
│   ├── models/                       # 12 domain models (Equatable)
│   └── static/                       # Compile-time data for all 6 modules
├── features/                         # 14 feature subdirectories (alphabet, numbers, colors, shapes, days, months, rewards, parent_dashboard, robot, settings, daily, home, splash, style_guide)
├── l10n/                             # Localization (app_en.arb)
├── theme/app_theme.dart              # ThemeData with useMaterial3: true
├── utils/tts_helper.dart             # TtsHelper singleton
├── models/item_model.dart            # Old v1 model (kept for reference)
├── screens/                          # Old v1 screens (kept for reference)
└── widgets/                          # Old v1 widgets (kept for reference)
```

## Getting Started

### Prerequisites

- Flutter 3.44.2+
- Android SDK (API 21+) — set `ANDROID_HOME`
- Java 17+ — set `JAVA_HOME`
- Windows Developer Mode (for plugin symlinks on Windows)

### Install & Run

```bash
flutter pub get
flutter run
```

### Run on running emulator

```bash
flutter run -d emulator-5554
```

### Build Release APK

```bash
flutter build apk --release --split-per-abi
```

Output (3 ABIs, ~15–19 MB each):

```
build/app/outputs/flutter-apk/
├── app-armeabi-v7a-release.apk
├── app-arm64-v8a-release.apk
└── app-x86_64-release.apk
```

## Documentation

| File | Contents |
|------|----------|
| `docs/ARCHITECTURE.md` | Full architecture, folder structure, data flow |
| `docs/DESIGN_SYSTEM.md` | All colour tokens, typography, spacing, animations |
| `docs/SCREEN_CATALOG.md` | All 188 screen specs organised by module |
| `docs/data_model.md` | All 12 domain models with field descriptions |
| `docs/MONETIZATION_GUIDE.md` | Step-by-step guide to activate ads, IAP, and parent gate |
| `docs/ROADMAP.md` | Sprint history and v2.0 candidate items |

## Known Issues

- `flutter_tts` applies Kotlin Gradle Plugin — future Flutter upgrade may need `android.builtInKotlin=true`
- Assets directory is empty (emoji placeholder strategy)
- Production monetisation is stubbed — see `docs/MONETIZATION_GUIDE.md` to activate
- No CI/CD, no pre-commit hooks, no formatter config

## License

MIT License — see [`LICENSE`](LICENSE) for details.
