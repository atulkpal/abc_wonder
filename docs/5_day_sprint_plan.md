# Sprint: ABC Wonder v1.0

**Goal**: Ship a working, tested app in 5 days.

---

## Day 1 — Foundation (8h)

- [x] `flutter create abc_wonder`
- [x] Set up folder structure (lib/theme, models, data, screens, widgets, utils)
- [x] Write all 6 docs
- [ ] `pubspec.yaml` — add provider, go_router, flutter_screenutil, flutter_tts
- [ ] `app_theme.dart` — full ThemeData with palette + typography
- [ ] `app.dart` — GoRouter with all routes (placeholder screens)
- [ ] Responsive setup — `main.dart` with `ScreenUtilInit`
- [ ] All 4 model classes
- [ ] All 4 static data files (alphabet_data, number_data, days_data, months_data)
- [ ] `TtsHelper` — flutter_tts wrapper (slow rate)
- [ ] `SplashScreen` — animated logo, auto-navigate after 2s

## Day 2 — Home + Alphabet (8h)

- [ ] `HomeScreen` — 2×2 / 4×2 category grid
- [ ] `CategoryCard` widget with icon + label
- [ ] `AlphabetScreen` — scrollable grid of LetterCards
- [ ] `LetterCard` — tap → speak TTS + scale animation
- [ ] Responsive: phone 4 cols, tablet 6 cols

## Day 3 — Numbers (8h)

- [ ] `NumberScreen` — grid of NumberCards
- [ ] `NumberCard` — shows digit + emoji object count
- [ ] TTS on tap for numbers 1–100
- [ ] Responsive layout

## Day 4 — Days + Months (8h)

- [ ] `DaysScreen` — 7 cards with emoji icons
- [ ] `MonthsScreen` — 12 cards with season emoji
- [ ] TTS for all 19 items
- [ ] Back navigation polish

## Day 5 — Polish, Test, Build (8h)

- [ ] Animated transitions (fade + scale between screens)
- [ ] Tablet testing — 600dp, 800dp widths
- [ ] Landscape orientation support
- [ ] Test on real devices / emulators
- [ ] `flutter build apk --split-per-abi`
- [ ] `flutter build ios` (if on macOS)
- [ ] Smoke test all 4 categories end-to-end
- [ ] APK size check (< 30 MB)
