# ABC Wonder — Architecture

## Overview

ABC Wonder is a premium children's learning platform (ages 2-4) built with Flutter 3.44+ / Dart 3.12+. It consists of 6 learning modules, a reward system, robot companion, parent dashboard, and 188+ screen specifications.

## Tech Stack

| Layer | Choice |
|-------|--------|
| Framework | Flutter 3.44+ / Dart 3.12+ |
| State Management | Riverpod (flutter_riverpod + riverpod_annotation) |
| Navigation | GoRouter (declarative, deep linking) |
| Persistence | Hive (local, offline-first) + shared_preferences |
| Audio | flutter_tts ^4.2.2 (TTS) |
| Charts | fl_chart (parent dashboard) |
| Fonts | Plus Jakarta Sans (headlines), Nunito Sans (body) |
| Localization | flutter_localizations + intl (.arb files) |
| Min SDK | Android API 21 / iOS 13 |

## Architecture Diagram

```
app_bootstrap.dart
    │
    ├── init TtsHelper (singleton)
    ├── init MonetizationService
    ├── (Hive boxes stubbed — not yet wired)
    └── runApp(App)

App (MaterialApp.router)
    │
    ├── theme (AppTheme — design tokens)
    ├── router (GoRouter — 30+ routes)
    │
    └── routes
        ├── / → SplashScreen
        ├── /home → MagicalHubScreen
        ├── /alphabet → AlphabetHubScreen
        ├── /alphabet/:letter → AlphabetDetailScreen
        ├── /alphabet/review → AlphabetReviewScreen
        ├── /alphabet/celebration → AlphabetCelebrationScreen
        ├── /numbers → NumberHubScreen
        ├── /numbers/:number → NumberDetailScreen
        ├── /numbers/quiz → NumberQuizScreen
        ├── /numbers/counting → CountingGameScreen
        ├── /colors → ColorsHubScreen
        ├── /colors/:color → ColorDetailScreen
        ├── /colors/matching → ColorMatchingScreen
        ├── /colors/search → ColorSearchScreen
        ├── /colors/quiz → ColorQuizScreen
        ├── /shapes → ShapesHubScreen
        ├── /shapes/:shape → ShapeDetailScreen
        ├── /shapes/builder → ShapeBuilderScreen
        ├── /shapes/puzzle → ShapePuzzleScreen
        ├── /shapes/hunt → ShapeHuntScreen
        ├── /days → DaysHubScreen
        ├── /days/:day → DayDetailScreen
        ├── /days/builder → WeekBuilderScreen
        ├── /days/quiz → WeeklyQuizScreen
        ├── /months → MonthsHubScreen
        ├── /months/:month → MonthDetailScreen
        ├── /months/explorer → FullYearExplorerScreen
        ├── /stickers → StickerMuseumScreen
        ├── /achievements → AchievementsHubScreen
        ├── /robot-lab → RobotLabScreen
        ├── /parent → ParentDashboardScreen
        └── /parent/progress → ParentProgressScreen
```

## Folder Structure

```
lib/
├── main.dart                          # Entrypoint
├── app.dart                           # MaterialApp.router + theme
├── bootstrap/
│   ├── app_bootstrap.dart             # Init chain (TTS, Hive, router)
│   └── router.dart                    # GoRouter config (all routes + transitions)
├── core/
│   ├── constants/
│   │   ├── app_constants.dart         # Design tokens, spacing, breakpoints
│   │   └── asset_paths.dart           # Asset directory paths
│   ├── theme/
│   │   ├── app_theme.dart             # ThemeData using design tokens
│   │   ├── colors.dart                # Full MD3 color token palette
│   │   ├── typography.dart            # Font families + text style presets
│   │   └── dimensions.dart            # Spacing, radius, shadow system
│   ├── utils/
│   │   ├── tts_helper.dart            # FlutterTts singleton (rate 0.4, pitch 1.1, en-US)
│   │   ├── audio_helper.dart          # Sound effects for interactions
│   │   ├── hive_helper.dart           # Hive box management
│   │   └── logger.dart                # Debug logging wrapper
│   ├── widgets/
│   │   ├── pressable_3d.dart          # 3D press wrapper (translateY + rim shadow)
│   │   ├── squishy_button.dart        # Squish-click button (scale + border-bottom)
│   │   ├── rim_card.dart              # Card with inset glow + bottom rim shadow
│   │   ├── bead_progress.dart         # Step indicator dots
│   │   ├── animated_float.dart        # Continuous floating animation
│   │   ├── shimmer_loading.dart       # Skeleton loading state
│   │   ├── inner_glow_top.dart        # Inset white top shadow overlay
│   │   └── toy_shadow.dart            # Large drop shadow decorator
│   └── extensions/
│       ├── context_extensions.dart    # BuildContext helpers
│       └── string_extensions.dart     # String utilities
├── data/
│   ├── models/
│   │   ├── letter_model.dart
│   │   ├── number_model.dart
│   │   ├── color_model.dart
│   │   ├── shape_model.dart
│   │   ├── day_model.dart
│   │   ├── month_model.dart
│   │   ├── reward_model.dart
│   │   ├── sticker_model.dart
│   │   ├── achievement_model.dart
│   │   ├── progress_model.dart
│   │   ├── user_model.dart
│   │   └── robot_model.dart
│   ├── repositories/
│   │   ├── progress_repository.dart   # Read/write progress via Hive
│   │   ├── rewards_repository.dart    # Sticker/achievement state
│   │   ├── settings_repository.dart   # User preferences
│   │   └── learning_repository.dart   # Module completion logic
│   └── local/
│       ├── hive_boxes.dart            # Hive box definitions
│       └── hive_adapters.dart         # Type adapters for models
├── features/
│   ├── splash/
│   │   └── splash_screen.dart         # Animated logo + robot (2s → /home)
│   ├── home/
│   │   ├── magical_hub_screen.dart    # 2×3 grid + robot greeting
│   │   ├── home_view_model.dart       # Hub state (progress summaries)
│   │   └── widgets/
│   │       ├── module_card.dart       # Color-coded module tile with progress
│   │       ├── robot_greeting.dart    # Mascot with speech bubble
│   │       └── daily_surprise_badge.dart
│   ├── alphabet/
│   │   ├── alphabet_hub_screen.dart
│   │   ├── alphabet_detail_screen.dart
│   │   ├── alphabet_review_screen.dart
│   │   ├── alphabet_celebration_screen.dart
│   │   ├── alphabet_view_model.dart
│   │   └── widgets/
│   │       ├── letter_card.dart
│   │       └── alphabet_sticker_grid.dart
│   ├── numbers/
│   │   ├── number_hub_screen.dart
│   │   ├── number_detail_screen.dart
│   │   ├── number_quiz_screen.dart
│   │   ├── counting_game_screen.dart
│   │   ├── number_celebration_screen.dart
│   │   ├── number_view_model.dart
│   │   └── widgets/
│   │       ├── number_card.dart
│   │       ├── counting_grid.dart
│   │       └── number_progress_bar.dart
│   ├── colors/
│   │   ├── colors_hub_screen.dart
│   │   ├── color_detail_screen.dart
│   │   ├── color_matching_screen.dart
│   │   ├── color_search_screen.dart
│   │   ├── color_quiz_screen.dart
│   │   ├── color_celebration_screen.dart
│   │   ├── color_view_model.dart
│   │   └── widgets/
│   │       ├── color_swatch_card.dart
│   │       ├── paint_splash_hero.dart
│   │       └── sorting_game_tile.dart
│   ├── shapes/
│   │   ├── shapes_hub_screen.dart
│   │   ├── shape_detail_screen.dart
│   │   ├── shape_builder_screen.dart
│   │   ├── shape_puzzle_screen.dart
│   │   ├── shape_hunt_screen.dart
│   │   ├── shape_celebration_screen.dart
│   │   ├── shape_view_model.dart
│   │   └── widgets/
│   │       ├── shape_card.dart
│   │       ├── shape_builder_canvas.dart
│   │       └── drag_target_zone.dart
│   ├── days/
│   │   ├── days_hub_screen.dart
│   │   ├── day_detail_screen.dart
│   │   ├── week_builder_screen.dart
│   │   ├── day_sequencing_screen.dart
│   │   ├── day_discovery_game_screen.dart
│   │   ├── weekly_quiz_screen.dart
│   │   ├── day_celebration_screen.dart
│   │   ├── day_view_model.dart
│   │   └── widgets/
│   │       ├── day_card.dart
│   │       ├── week_calendar.dart
│   │       └── sequencing_drop_zone.dart
│   ├── months/
│   │   ├── months_hub_screen.dart
│   │   ├── month_detail_screen.dart
│   │   ├── full_year_explorer_screen.dart
│   │   ├── month_discovery_game_screen.dart
│   │   ├── month_celebration_screen.dart
│   │   ├── month_view_model.dart
│   │   └── widgets/
│   │       ├── month_card.dart
│   │       ├── seasonal_background.dart
│   │       └── year_overview.dart
│   ├── rewards/
│   │   ├── sticker_museum_screen.dart
│   │   ├── achievements_hub_screen.dart
│   │   ├── treasure_chest_screen.dart
│   │   ├── hall_of_champions_screen.dart
│   │   ├── big_win_screen.dart
│   │   ├── reward_view_model.dart
│   │   └── widgets/
│   │       ├── sticker_grid.dart
│   │       ├── sticker_slot.dart
│   │       ├── achievement_badge_3d.dart
│   │       ├── progress_bar_liquid.dart
│   │       ├── metallic_gradient.dart
│   │       └── gem_gradient.dart
│   ├── robot/
│   │   ├── robot_lab_screen.dart
│   │   ├── robot_view_model.dart
│   │   └── widgets/
│   │       ├── robot_customizer.dart
│   │       ├── color_picker_wheel.dart
│   │       └── blueprint_background.dart
│   ├── parent_dashboard/
│   │   ├── parent_dashboard_screen.dart
│   │   ├── parent_progress_screen.dart
│   │   ├── parent_settings_screen.dart
│   │   ├── parent_view_model.dart
│   │   └── widgets/
│   │       ├── parent_gate.dart          # Math puzzle lock
│   │       ├── summary_bento_card.dart
│   │       ├── weekly_activity_chart.dart
│   │       ├── donut_chart.dart
│   │       └── achievement_feed_item.dart
│   ├── daily/
│   │   ├── daily_surprise_screen.dart
│   │   ├── daily_practice_screen.dart
│   │   ├── learning_streak_screen.dart
│   │   └── seasonal_celebration_screen.dart
│   └── settings/
│       └── settings_screen.dart
└── l10n/
    ├── app_en.arb
    ├── app_es.arb
    └── app_hi.arb
```

## Data Flow

```
[Static Data] → [Repository reads from static lists + Hive persistence]
     │
     ├── [ViewModel (Riverpod StateNotifier/AsyncNotifier)]
     │        │
     │        ├── Screens read via ref.watch()
     │        └── User actions call ref.read().action()
     │
     ├── [Hive Boxes] ←── progress, rewards, settings, robot customization
     │
     └── [TtsHelper] ←── singleton, called from ViewModels or directly from screens
```

## State Management (Riverpod)

- **Stateless data** (static lists): `Provider<LetterModel>` etc.
- **Async data** (persisted): `AsyncNotifierProvider` with loading/error/data states
- **UI state** (page index, animation): `StateProvider`
- **Feature state** (module progress, stickers): `StateNotifierProvider`

## Navigation (GoRouter)

- Shell route for bottom nav structure (Play / Learn / Parents)
- Typed `extra` arguments for passing module/item data
- Custom transitions per module (slide, fade, scale)
- Deep linking support for future badge/notification integration

## Design Token System

All UI tokens are extracted from the 188 HTML screen specifications. See `docs/DESIGN_SYSTEM.md` for the full token set. Key tokens:

| Token | Value | Usage |
|-------|-------|-------|
| surface | `#f5faff` | Page backgrounds |
| primary | `#00668a` | Primary actions, active states |
| tertiary | `#bb0054` | Accent, highlights |
| secondary | `#705d00` | Secondary elements |
| secondary-container | `#fdd400` | Gold/yellow containers |
| on-surface | `#171c20` | Body text |
| on-primary | `#ffffff` | Text on primary |

## Animation System

All animation patterns are direct ports from the HTML/CSS specs:

| CSS Class | Flutter Widget | Effect |
|-----------|---------------|--------|
| `pressable-3d` | `Pressable3D` | translateY(4px) + remove rim shadow on press |
| `squish-click` | `SquishButton` | scale(0.95) + translateY + border-bottom compensation |
| `squishy-btn` | `SquishyButton` | 6px bottom rim, 6px translateY on press |
| `rim-primary` | `RimDecoration` | 6px solid bottom border in primary color |
| `bead-progress` | `BeadProgress` | 24px circle dot indicators |
| `tactile-card` | `TactileCard` | Inset white glow + soft colored shadow |
| `inner-glow-top` | `InnerGlowTop` | Inset white gradient from top |
| `toy-shadow` | `ToyShadow` | Large drop shadow with color tint |
| `floating-bounce` | `AnimatedFloat` | Continuous translateY oscillation |
| `apple-wiggle` | `WiggleAnimation` | Rotate + scale on trigger |
| `pulse-ring` | `PulseRing` | Scale-out + opacity fade on tap |
| `shimmer-bg` | `ShimmerLoading` | Gradient sweep animation |
| `metallic-gold` | `MetallicGradient` | Gold radial gradient for badges |
| `gem-ruby` | `GemGradient` | Ruby gem radial gradient |

## Asset Organization

```
assets/
├── images/
│   ├── letters/          # A.png, B.png, ... Z.png
│   ├── numbers/          # 1.png, 2.png, ... 100.png
│   ├── colors/           # red.png, blue.png, ...
│   ├── shapes/           # circle.png, square.png, ...
│   ├── days/             # monday.png, ...
│   ├── months/           # january.png, ...
│   ├── backgrounds/      # Module-specific backgrounds
│   ├── stickers/         # 50+ sticker images
│   ├── badges/           # Achievement badges
│   ├── robot/            # Robot sprites (idle, wave, talk, celebrate)
│   └── ui/               # Shared UI elements
├── fonts/
│   ├── PlusJakartaSans-Bold.ttf
│   ├── PlusJakartaSans-ExtraBold.ttf
│   ├── NunitoSans-Regular.ttf
│   ├── NunitoSans-SemiBold.ttf
│   └── NunitoSans-Bold.ttf
└── animations/           # Lottie/Rive complex animations
```

## Performance Targets

- Cold start < 2s
- 60fps scrolling through all module screens
- APK < 30 MB per ABI
- Memory < 100 MB peak
- No jank on API 21 devices (Nexus 5 class)

## Key Constraints

- No ads, no tracking, no data collection, no in-app purchases
- 100% offline capable (no network required after install)
- Touch targets minimum 64dp (48dp absolute floor)
- All content is compile-time constants + local persistence
- Single codebase targets both phone and tablet (600dp+ breakpoint)
