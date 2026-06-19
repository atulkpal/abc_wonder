# ABC Wonder — Modernization Roadmap

## Overview

12-sprint plan to transform the current 8-file, 4-module prototype into a 188-screen premium children's learning platform. Each sprint produces shippable, testable increments.

---

## Sprint 1 — Foundation Refactor ✅

**Duration:** 5-7 days | **Complexity:** Medium | **Dependencies:** None

### Goals
- Scaffold scalable architecture alongside existing code
- Add state management, persistence, and routing frameworks
- Define all domain models

### Deliverables
| Category | Items |
|----------|-------|
| **Structure** | Feature-based folder layout; `core/`, `data/`, `features/`, `bootstrap/` directories |
| **State** | Riverpod integration; Provider/StateNotifier pattern stubs per module |
| **Persistence** | Hive + shared_preferences; box definitions; progress/settings/rewards adapters |
| **Navigation** | GoRouter with all 30+ route stubs; shell route structure; transition placeholders |
| **Models** | 12 domain models: LetterModel, NumberModel, ColorModel, ShapeModel, DayModel, MonthModel, RewardModel, StickerModel, AchievementModel, ProgressModel, UserModel, RobotModel |
| **Data migration** | Convert existing `ItemModel` data to domain-specific models; keep old files intact |
| **Dependencies** | Add to pubspec: flutter_riverpod, go_router, hive, hive_flutter, flutter_localizations, intl, equatable, fl_chart |
| **Bootstrap** | app_bootstrap.dart with init chain (TTS → Hive → Router → runApp) |

### Risks
- Hive type adapters require codegen (`hive_generator` + `build_runner`)
- Keeping old architecture running alongside new one requires careful import management

### Acceptance Criteria
- `flutter analyze` passes with new dependencies
- `flutter test` still passes (existing test)
- App runs on emulator with no regression
- All route stubs are reachable (placeholder screens)

---

## Sprint 2 — Design System ✅

**Duration:** 5-7 days | **Complexity:** Medium | **Dependencies:** Sprint 1

### Goals
- Port all visual tokens from HTML specs into Flutter
- Build all core reusable widgets
- Create StyleGuide for visual QA

### Deliverables
| Category | Items |
|----------|-------|
| **Colors** | Full MD3 token palette (`colors.dart`) — 50+ color constants matching spec |
| **Typography** | Font registration (Plus Jakarta Sans + Nunito Sans); `typography.dart` with all 5 text presets |
| **Dimensions** | `dimensions.dart` — spacing system, border radius, breakpoints |
| **Theme** | Updated `app_theme.dart` consuming all tokens |
| **Core widgets** | Pressable3D, SquishyButton, RimCard, TactileCard, BeadProgress, AnimatedFloat, ShimmerLoading, InnerGlowTop, ToyShadow, RimDecoration, PulseRing, WiggleAnimation, SparkleOverlay |
| **Gradient widgets** | MetallicGradient (gold/silver), GemGradient (ruby/sapphire/emerald), SeasonalGradient, PaintSplashHero |
| **StyleGuide** | Screen showing all tokens, widgets, and typography for visual approval |

### Key Spec Files
All 188 specs share the same Tailwind config. Extract exact values from:
- `magical_hub_1/code.html` — primary palette + spacing + fonts
- `alphabet_adventure_a/code.html` — rim shadows, bead progress, pressable-3d, wiggle, floating-bounce
- `number_kingdom/code.html` — tactile-card, squishy-btn, animate-float
- `shapes_factory/code.html` — squish-bounce, pulse-ring, float-mascot
- `achievements_hub/code.html` — metallic-gold, gem-ruby, badge-3d, liquid-progress
- `sticker_museum/code.html` — felt-texture, scrapbook-page, sticker-card
- `robot_lab/code.html` — blueprint-pattern, glow-tube, workshop-bg
- `parent_progress_dashboard/code.html` — shimmer-bg, donut segment animation

### Risks
- Animation timing parity with CSS (need frame-by-frame comparison)
- Font file size impact on APK (mitigate with Google Fonts for dev)

### Acceptance Criteria
- StyleGuide screen renders all 50+ color tokens correctly
- All 15 core widgets work in isolation
- Pressable3D replicates the `translateY(4px) + box-shadow: none` behavior
- `flutter analyze` passes

---

## Sprint 3 — Navigation & Magical Hub ✅

**Duration:** 4-6 days | **Complexity:** Medium | **Dependencies:** Sprint 1 (GoRouter) + Sprint 2 (widgets)

### Goals
- Replace old navigation system
- Build magical hub home screen per spec
- Implement robot mascot widget

### Deliverables
| Screen | Spec File | Key Features |
|--------|-----------|--------------|
| **SplashScreen** | `splash_screen/` | Animated logo, 2s auto-navigate |
| **MagicalHubScreen** | `magical_hub_1/` | TopAppBar (back + title + robot icon), hero section (robot bouncing + speech bubble), 2×3 module grid (Alphabet, Numbers, Colors, Shapes, Days, Months) with progress bars per card, bottom nav (Play/Learn/Parents) |
| **RobotMascotWidget** | `abc_wonder_robot_mascot/` | Bounce animation (3s infinite), speech bubble (opacity 0→1→0), wave gesture, pressable-3d interaction |
| **Old nav deprecation** | — | Remove old `MaterialApp` routes; keep old screens accessible via new routes |

### Route Structure (finalized)
```
/ → SplashScreen
/home → MagicalHubScreen
/alphabet → AlphabetHubScreen
/alphabet/:letter → AlphabetDetailScreen
/alphabet/review → AlphabetReviewScreen
/alphabet/celebration → AlphabetCelebrationScreen
/alphabet/stickers → AlphabetStickerScreen
/numbers → NumberHubScreen
... (30+ routes matching SCREEN_CATALOG.md)
```

### Risks
- Robot mascot image asset needed (use placeholder from emoji initially)
- Six module cards with progress bars need mock data until persistence is seeded

### Acceptance Criteria
- Magical hub renders 6 module cards with tap navigation
- Robot mascot bounces + shows speech bubble
- Bottom nav switches between Play/Learn/Parents tabs
- Old splash screen still works via new route
- Tablet layout shows proper breakpoints

---

## Sprint 4 — Alphabet Modernization ✅

**Duration:** 5-7 days | **Complexity:** Medium | **Dependencies:** Sprint 2 + Sprint 3

### Goals
- Build Alphabet Adventure module per its 32 screen specs
- Implement per-letter parameterized detail screen
- Add progress persistence + sticker unlock

### Deliverables
| Screen | Spec File(s) |
|--------|--------------|
| **AlphabetHubScreen** | `alphabet_adventure/` |
| **AlphabetDetailScreen** (parameterized ×26) | `alphabet_adventure_a/` through `_z/` |
| **AlphabetReviewScreen** | `alphabet_review_challenge/` |
| **AlphabetProgressScreen** | `alphabet_progress_map/` |
| **AlphabetCelebrationScreen** | `alphabet_completion_celebration/` |
| **AlphabetStickerScreen** | `alphabet_sticker_collection/` |

### Key Implementation Notes
- `AlphabetDetailScreen` is **one parameterized screen** driven by `LetterModel` data
- Each letter screen layout: TopAppBar → uppercase/lowercase tiles → word banner → interactive character scene → robot mascot → bead progress (26 dots) → bottom nav (Back/Hub/Next)
- Interactive scene per letter (apple tree for A) — use parameterized animation widget
- Bead progress tracks completion across all 26 letters
- Sticker unlocks when letter is completed
- TTS integration from existing `TtsHelper`

### Risks
- 26 interactive scenes require different animations → mitigate with scene template + data-driven config
- BeadProgress with 26 dots may be too wide on phone → use horizontal scroll or truncated view

### Acceptance Criteria
- All 26 letter screens render correctly
- TTS plays letter name on tap
- Bead progress persists across sessions
- Sticker appears in collection on completion
- `alphabet_review_challenge` works as a quiz

---

## Sprint 5 — Numbers Modernization ✅

**Duration:** 5-7 days | **Complexity:** Medium | **Dependencies:** Sprint 2 + Sprint 3

### Goals
- Build Number Kingdom module per its 15 screen specs
- Implement counting games and number quiz

### Deliverables
| Screen | Spec File(s) |
|--------|--------------|
| **NumberHubScreen** | `number_kingdom/` |
| **NumberDetailScreen** (parameterized ×10) | `number_kingdom_1/` through `_10/` |
| **CountingGameScreen** | `counting_activity_1_5/`, `counting_challenge_6_10/` |
| **NumberQuizScreen** | `number_kingdom_1_10/` (quiz variant) |
| **NumberProgressScreen** | `number_progress_map/` |
| **NumberCelebrationScreen** | `number_kingdom_completion_celebration/` |
| **NumberRewardScreen** | `number_reward_golden_star/` |

### Key Patterns from Spec
- Use `tactile-card` + `squishy-btn` with staggered floating animations
- `animate-float-1/2/3` classes apply different animation durations/delays
- Counting screens show objects to count with tap interaction

### Risks
- 100 numbers in 10 groups → pagination/grouping UX needs careful design for 2-4 age range
- Counting game drag interaction complex on small screens

### Acceptance Criteria
- All number groups render with correct counting display
- Counting game allows tapping to count objects
- Quiz screen presents multiple choice (2-3 options)
- Progress persists across sessions

---

## Sprint 6 — Colors World ✅

**Duration:** 4-6 days | **Complexity:** Medium | **Dependencies:** Sprint 2 + Sprint 3

### Goals
- Build new Colors World module per 21 screen specs
- Implement color matching and search games

### Deliverables
| Category | Screens |
|----------|---------|
| **Hub** | `colors_world/`, `colors_world_remaining_colors/` |
| **Detail (×11)** | All `color_*` screens |
| **Games** | `color_matching_challenge/`, `color_matching_game/`, `color_search_challenge/`, `color_detective_challenge/`, `color_discovery_challenge/`, `find_the_color_challenge/`, `color_quiz_arena/` |
| **Sorting games** | `black_vs_white_sorting_game/` etc. (see SCREEN_CATALOG) |
| **Progress** | `color_progress_map/`, `color_sticker_collection/` |
| **Celebrations** | `color_explorer_celebration/`, `color_master_celebration/`, `color_master_certificate/` + mini sorting celebrations |

### Key Patterns
- Each detail screen has a unique gradient background — parameterize with color data
- Paint-splash hero effect (`blur-3xl` behind color name)
- `wiggle-on-tap` animation (rotate + scale down)

### Risks
- Color differentiation for 2-year-olds (red/orange, blue/purple may be hard)
- Sorting games need drag-and-drop gesture handling

### Acceptance Criteria
- All 11 color screens render with correct gradients
- Matching game allows drag interaction
- Quiz presents color identification questions
- Progress tracked and stickers rewarded

---

## Sprint 7 — Shapes Factory ✅

**Duration:** 4-6 days | **Complexity:** Medium | **Dependencies:** Sprint 2 + Sprint 3

### Goals
- Build Shapes Factory module per 24 screen specs
- Implement shape builder workshop with drag-and-drop

### Deliverables
| Category | Screens |
|----------|---------|
| **Hub** | `shapes_factory/`, `shapes_factory_remaining_shapes/` |
| **Detail (×8)** | `shape_*` (circle through star) |
| **Workshop** | `shape_builder_workshop/` |
| **Puzzle** | `shape_puzzle_world/` |
| **Games** | `shape_matching_challenge/`, `shape_quiz_arena/`, `shape_discovery_challenge_1/2/`, `shape_hunt_adventure/`, `shape_hunt_challenge_1/2/` |
| **Sorting** | `circle_vs_square_sorting_game/`, `triangle_vs_rectangle_sorting_game/`, `heart_vs_diamond_sorting_game/`, `oval_vs_star_sorting_game/` |
| **Progress** | `shape_progress_map/`, `shape_sticker_collection/` |
| **Celebrations** | 6 celebration/certificate screens (see SCREEN_CATALOG) |

### Key Patterns
- `squish-bounce` keyframe (scale + translateY)
- `float-slow` (translateY + rotate)
- `pulse-ring` (scale-out/opacity-fade for tap feedback)
- `btn-3d` (border-bottom press with margin compensation)
- Material Symbols with `FILL=1, wght=600`

### Risks
- Shape builder requires sophisticated `Draggable`/`DragTarget` with snap zones
- Shape puzzle needs collision detection or region-based matching

### Acceptance Criteria
- All 8 shape screens render with correct animations
- Builder workshop allows drag-to-construct
- Puzzle screen validates correct shape placement
- Progress persists

---

## Sprint 7.5 — Monetization Framework ✅

**Duration:** 1-2 days | **Complexity:** Easy | **Dependencies:** Sprint 3

### Goals
- Build non-intrusive monetization abstraction layer
- Add parent gate and contextual ad placements
- Create detailed activation guide for future go-live

### Deliverables
| File | Purpose |
|------|---------|
| `lib/core/monetization/monetization_service.dart` | Abstract interface + AdPlacements constants (7 placement keys with contextual keywords) |
| `lib/core/monetization/dev_monetization_service.dart` | No-op impl — zero ad code in dev |
| `lib/core/monetization/production_monetization_service.dart` | Production stub with `areAdsEnabled = false` |
| `lib/core/monetization/monetization_provider.dart` | Riverpod Provider — swap Dev ↔ Production via one line |
| `lib/core/monetization/ad_banner_widget.dart` | ConsumerWidget — returns SizedBox.shrink() until ads activated |
| `lib/core/monetization/parent_gate.dart` | Math puzzle dialog + ParentGatedWidget wrapper |
| `docs/MONETIZATION_GUIDE.md` | Step-by-step activation guide (14 steps) |

### Ad Placement Rules
| Screen | Format | Shows when |
|--------|--------|------------|
| Module hubs (×6) | Contextual banner | `!isPremium && areAdsEnabled` |
| Parent dashboard | Native ad card | `!isPremium && areAdsEnabled` |
| Detail / Games / Celebrations | Never | — |

### Key Design
- Every ad method returns `Widget?` — `null` = zero visual traces, no empty containers, no gray boxes
- Contextual keywords (e.g. "alphabet-blocks") — COPPA-compliant, no behavioral tracking
- Parent gate: session-level pass (once per cold start)
- Single IAP product: `remove_ads` (non-consumable)

### Acceptance Criteria
- Zero ad SDKs in dev / analyzer passes
- No visible ad placeholders anywhere
- Parent gate wraps `/parent` route
- Guide documents all 14 steps to go live

---

## Sprint 8 — Days Playground ✅

**Duration:** 3-5 days | **Complexity:** Easy | **Dependencies:** Sprint 2 + Sprint 3

### Goals
- Build Days Playground module per 26 screen specs
- Implement week builder and sequencing games

### Deliverables
| Category | Screens |
|----------|---------|
| **Hub** | `days_playground/`, `days_playground_full_week/` |
| **Detail (×7)** | All `day_*` screens |
| **Games** | `day_matching_challenge/`, `day_sequencing_challenge/`, `week_builder_game/`, `week_review_world/`, `weekly_quiz_arena/`, comparison games (×3) |
| **Progress** | `days_progress_map/`, `days_sticker_collection/` |
| **Celebrations** | 9 screens (see SCREEN_CATALOG) |

### Key Patterns
- `squishy-btn` + `soft-card` with inset white glow + soft shadow
- Gentle float animation (`translateY -10px`)
- `TopAppBar`: fixed, back arrow, "ABC Wonder" title, `smart_toy` icon

### Acceptance Criteria
- All 7 day screens render with correct layouts
- Week builder allows ordering days correctly
- Sequencing challenge tests day order knowledge
- Progress persists

---

## Sprint 9 — Month Explorer ✅

**Duration:** 3-5 days | **Complexity:** Easy | **Dependencies:** Sprint 2 + Sprint 3

### Goals
- Build Month Explorer module per 18 screen specs
- Implement full-year explorer and discovery games

### Deliverables
| Category | Screens |
|----------|---------|
| **Hub** | `month_explorer/`, `month_explorer_full_year/` |
| **Detail (×12)** | All `month_*` screens |
| **Games** | `month_discovery_game_1/` through `_4/` |

### Key Patterns
- Each month has a unique seasonal gradient (snow for Jan, flowers for Mar, etc.)
- Default: `snow-gradient` (linear-gradient #f5faff → #c3e8ff)
- `TopAppBar` + robot mascot in every screen

### Acceptance Criteria
- All 12 month screens render with correct seasonal gradients
- Full-year explorer scrolls through all months
- Discovery games test month/season knowledge
- Progress persists

---

## Sprint 10 — Rewards System ✅

**Duration:** 6-8 days | **Complexity:** Hard | **Dependencies:** Sprints 4-9

### Goals
- Build complete rewards ecosystem: stickers, achievements, treasure chests, hall of champions
- Wire progress data from all 6 modules into reward state

### Deliverables
| Screen | Spec File | Key Features |
|--------|-----------|--------------|
| **StickerMuseumScreen** | `sticker_museum/` | Felt-texture background, scrapbook page aesthetic, category tabs (ABC/123/Colors/Animals), sticker grid with collected/locked states, zoom overlay with sound button, favorite stars per sticker, robot helper with speech bubble |
| **AchievementsHubScreen** | `achievements_hub/` | 3D badges with metallic gradients (gold/silver), gem gradients (ruby/sapphire/emerald), liquid/glassmorphism progress bars |
| **TreasureChestScreen** | `treasure_chest_reward/` | Animated chest opening with particle effects |
| **HallOfChampionsScreen** | `hall_of_champions/` | Mastered modules showcase with stats |
| **BigWinScreen** | `the_big_win/` | Grand celebration with confetti/particles |

### Architecture
```
RewardsRepository
├── StickerModel[] (all stickers across 6 modules + cross-module)
├── AchievementModel[] (badges with tiers: bronze/silver/gold)
│
├── Unlock conditions:
│   ├── Module: all letters/numbers/colors/etc. completed
│   ├── Streak: N days consecutive play
│   └── Score: quiz accuracy > X%
│
├── Hive boxes:
│   ├── sticker_box (Map<String, bool> — unlocked state per sticker)
│   └── achievement_box (Map<String, AchievementProgress>)
```

### Risks
- Sticker grid performance with 50+ items (use `GridView.builder`)
- Reward sound effects need audio assets
- Unlock condition logic is complex — needs thorough unit testing

### Acceptance Criteria
- Sticker museum shows collected/locked states correctly
- Unlocking sticker plays animation
- Achievements hub displays all badges with progress
- Treasure chest animates on open
- Hall of champions shows completed modules
- All data persists in Hive

---

## Sprint 11 — Parent Dashboard + Robot Lab + Misc ✅

**Duration:** 5-7 days | **Complexity:** Medium | **Dependencies:** Sprint 10

### Goals
- Build parent dashboard per spec (parent gate, bento grid, charts)
- Implement robot customization lab
- Add settings, daily surprise, learning streak, seasonal screens

### Deliverables
| Category | Screens |
|----------|---------|
| **Parent dashboard** | `parent_dashboard/`, `parent_progress_dashboard/`, `settings/` |
| **Robot lab** | `robot_lab/`, `avatar_creation/` |
| **Daily** | `daily_surprise/`, `daily_practice_mode/`, `daily_color_practice/`, `daily_shape_practice/`, `learning_streak/` |
| **Seasonal** | `seasonal_celebration/`, `grand_seasonal_celebration/`, `season_explorer_celebration_1/2/`, `rainbow_treasure_hunt/`, `night_snow_discovery_challenge/` |
| **Other** | `magical_toy/`, `offline_mode/`, `welcome_screen/` |

### Parent Dashboard Key Features
- Parent gate: math puzzle ("6 + 3 = ?") with shake animation on wrong answer
- Bento grid: Learning Time (42 mins), Daily Goal (70%), Avg Accuracy (85%), Stars Earned (450)
- Weekly Activity Chart: stacked bar chart (Mon-Sun) with hover tooltips
- Recent Achievements Feed: 3-5 recent items with timestamps
- Export Report button (PDF stub)
- Dark mode toggle
- Bottom nav: Hub/Stickers/Robot/Daily/Parents

### Robot Lab Key Features
- Workshop background (radial gradient + overflow hidden)
- Blueprint dot-grid pattern (32px grid)
- Glow tubes (animated vertical gradient tubes with pulsing opacity)
- Rim buttons (4px dark shadow)
- Viewport locked (`user-scalable=no`)

### Risks
- Chart rendering performance with fl_chart
- Parent gate must be simple enough for parent but non-bypassable by child
- Robot customization state needs Hive persistence

### Acceptance Criteria
- Parent gate requires correct math answer
- Dashboard shows real progress data from Hive
- Weekly chart renders correctly
- Robot lab allows customization with persisted state
- Settings screen updates TTS rate/language

---

## Sprint 12 — Polish & Optimization ✅

**Duration:** 5-7 days | **Complexity:** Medium | **Dependencies:** All prior sprints

### Goals
- Full QA pass across all screens
- Performance optimization
- Documentation cleanup
- APK build verification

### Deliverables Completed
| Category | Status |
|----------|--------|
| **Lint** | `flutter analyze` — zero issues ✅ |
| **Const correctness** | Analyzer-enforced via `flutter_lints`; all widget constructors const ✅ |
| **Performance** | `RepaintBoundary` on AnimatedFloat, SparkleOverlay, RobotMascot, WiggleAnimation, PulseRing, ShimmerLoading ✅ |
| **Tests** | 6 data integrity tests across all modules; old v1 overflow test replaced ✅ |
| **Docs** | Stale `docs/app_architecture.md` and `docs/design_guidelines.md` removed; AGENTS.md updated ✅ |
| **APK build** | `flutter build apk --debug` succeeds ✅ |

### Known at v1.0
- `flutter_tts` applies Kotlin Gradle Plugin (future Flutter upgrade may need `android.builtInKotlin=true`)
- Production monetization (AdMob + IAP) is stubbed — see `docs/MONETIZATION_GUIDE.md` to activate
- Assets directory is empty (emoji placeholder strategy)
- No CI/CD, no pre-commit hooks, no formatter config

---

## v2.0 — Future Work (Unplanned)

### Candidate items
| Area | Items |
|------|-------|
| **Monetization** | Activate ads + IAP per `MONETIZATION_GUIDE.md` (14 steps, 11 remaining) |
| **Assets** | Replace emoji placeholders with real illustrations |
| **Content** | Expand numbers back to 1–100 with pagination; add more games and quiz modes |
| **Platform** | iOS release build; tablet-optimised landscape layout |
| **Infrastructure** | CI/CD pipeline; pre-commit hooks; formatter config; Hive persistence wiring |
| **Performance** | APK size optimization (< 30 MB); `PageView.builder` migration; cold start profiling |
| **Animation** | Frame-by-frame parity with HTML specs |
| **Tests** | Widget tests for hub/detail/game screens; integration test for full happy path |

---

## Dependency Graph (v1.0)

```
Sprint 1 (Foundation)
    │
    ├──→ Sprint 2 (Design System)
    │        │
    │        ├──→ Sprint 3 (Nav & Hub)
    │        │        │
    │        │        ├──→ Sprint 4 (Alphabet) ──┐
    │        │        ├──→ Sprint 5 (Numbers) ───┤
    │        │        ├──→ Sprint 6 (Colors) ────┤
    │        │        ├──→ Sprint 7 (Shapes) ────┤
    │        │        ├──→ Sprint 8 (Days) ──────┤
    │        │        └──→ Sprint 9 (Months) ────┤
    │        │                                    │
    │        │                    ┌───────────────┘
    │        │                    ↓
    │        └──→ Sprint 3 ─────→ Sprint 10 (Rewards)
    │                                    │
    │                                    ↓
    │                             Sprint 11 (Parent + Misc)
    │                                    │
    │                                    ↓
    └──────────────────────────────→ Sprint 12 (Polish)
```

## Total Estimate

| Sprint | Days | Complexity |
|--------|------|------------|
| 1 — Foundation | 5-7 | Medium |
| 2 — Design System | 5-7 | Medium |
| 3 — Nav & Hub | 4-6 | Medium |
| 4 — Alphabet | 5-7 | Medium |
| 5 — Numbers | 5-7 | Medium |
| 6 — Colors | 4-6 | Medium |
| 7 — Shapes | 4-6 | Medium ✅ |
| 7.5 — Monetization | 1-2 | Easy ✅ |
| 8 — Days | 3-5 | Easy |
| 9 — Months | 3-5 | Easy ✅ |
| 10 — Rewards | 6-8 | Hard ✅ |
| 11 — Parent + Misc | 5-7 | Medium ✅ |
| 12 — Polish | 5-7 | Medium |
| **Total** | **55-78** | — |
