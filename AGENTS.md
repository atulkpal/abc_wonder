# ABC Wonder — Agent Guide

## Setup
- Flutter 3.44.2, Dart 3.12.2
- `ANDROID_HOME` = `$env:LOCALAPPDATA\Android\Sdk`
- `JAVA_HOME` = `C:\Program Files\Android\Android Studio\jbr`
- Windows Developer Mode required for plugin builds (symlinks)
- Emulator AVD name: `Medium_Phone`

## Commands
| Command | Purpose |
|---------|---------|
| `flutter pub get` | Install deps |
| `flutter analyze` | Lint + typecheck (run before every commit) |
| `flutter test` | Run tests |
| `flutter run -d emulator-5554` | Run on running emulator |
| `flutter build apk --release --split-per-abi` | Release APK (3 ABIs) |

## Architecture
- **Entrypoint:** `lib/main.dart` → `ProviderContainer` + `UncontrolledProviderScope` → `AppBootstrap.init()` → `MaterialApp.router`
- **Navigation:** GoRouter (`lib/bootstrap/router.dart`) with 30+ named + parameterized routes
- **State:** Riverpod via `ProviderContainer` (one provider wired: `monetizationProvider`)
- **Persistence:** Hive box names stubbed in `lib/data/local/hive_boxes.dart`; adapters stubbed, no Hive dep in pubspec yet
- **App name:** `lib/core/constants/app_constants.dart` → `AppConstants.appName`
- **Design tokens:** `lib/core/theme/` — `colors.dart` (50+ AppColors), `typography.dart` (5 AppTypography presets), `dimensions.dart` (AppDimensions)
- **Core widgets (14):** `lib/core/widgets/` — includes Pressable3D, SquishyButton, RimCard, TactileCard, BeadProgress, AnimatedFloat, ShimmerLoading, InnerGlowTop, ToyShadow, RimDecoration, PulseRing, WiggleAnimation, SparkleOverlay, RobotMascot
- **Gradients (4):** `lib/core/gradients/` — MetallicGradient, GemGradient, SeasonalGradient, PaintSplashHero
- **Theme:** `lib/theme/app_theme.dart` consumes all tokens, `useMaterial3: true`
- **Style guide:** `/style-guide` route at `lib/features/style_guide/style_guide_screen.dart`
- **Docs:** `docs/ARCHITECTURE.md`, `docs/DESIGN_SYSTEM.md`, `docs/SCREEN_CATALOG.md` (188 screens), `docs/DATA_MODEL.md`, `docs/MONETIZATION_GUIDE.md`, `docs/ROADMAP.md`

## Monetization Framework
- **Abstract service:** `lib/core/monetization/monetization_service.dart`, two impls: `DevMonetizationService` (no-ops) and `ProductionMonetizationService` (stubs, gated by `areAdsEnabled` = default `false`)
- All ad methods return `Widget?` — `null` = zero visual traces
- **Parent gate:** Math puzzle modal (`parent_gate.dart`) before ad clicks / IAP / parent dashboard; session-level pass
- **IAP:** Single `remove_ads` non-consumable; `purchaseRemoveAds()` → `isPremium = true` → all ads vanish
- No ad SDKs in dev bundle; add `google_mobile_ads` + `in_app_purchase` when activating

## Gotchas
- `flutter_screenutil` **not used** — use `MediaQuery`/`LayoutBuilder` with hardcoded dp
- Assets directory exists but is **empty** — emoji placeholder strategy; `ItemModel` has no `assetImage` field (old v1 model)
- Old v1 data files at `lib/data/alphabet_data.dart` etc. still exist alongside new `lib/data/static/*` — be careful which you import
- `flutter_tts` applies Kotlin Gradle Plugin — future Flutter upgrade may need `android.builtInKotlin=true`
- Emulator 1080×2400 (20:9); test 600dp+ for tablet layout
- No CI/CD, no pre-commit hooks, no formatter config
