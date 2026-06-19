# ABC Wonder — Screen Catalog

Complete catalog of all 188 screen specifications in `stitch_abc_wonder_learning_app/`. Each entry has `code.html` (full HTML/CSS/JS implementation) and `screen.png` (visual mockup).

---

## 1. Alphabet Adventure (32 screens)

### Hub & Navigation
| Directory | Screen Type | Parameters |
|-----------|-------------|------------|
| `alphabet_adventure/` | Module hub — progress map with 26 letter icons | None (static) |
| `alphabet_adventure_b_z/` | Grid of remaining letters (B-Z) | None (static) |

### Per-Letter Detail Screens (26 screens)
| Directory | Title | Key Content |
|-----------|-------|-------------|
| `alphabet_adventure_a/` | Alphabet Adventure — A | Uppercase/lowercase tiles, "APPLE" banner, apple character with wiggle, apple tree drop animation, robot mascot, bead progress |
| `alphabet_adventure_b/` | Alphabet Adventure — B | Same layout, "BALL" theme, ball character |
| `alphabet_adventure_c/` | Alphabet Adventure — C | Same layout, "CAT" theme, cat character |
| `alphabet_adventure_d/` | Alphabet Adventure — D | Same layout, "DOG" theme |
| `alphabet_adventure_e/` | Alphabet Adventure — E | Same layout |
| `alphabet_adventure_f/` | Alphabet Adventure — F | Same layout |
| `alphabet_adventure_g/` | Alphabet Adventure — G | Same layout |
| `alphabet_adventure_h/` | Alphabet Adventure — H | Same layout |
| `alphabet_adventure_i/` | Alphabet Adventure — I | Same layout |
| `alphabet_adventure_j/` | Alphabet Adventure — J | Same layout |
| `alphabet_adventure_k/` | Alphabet Adventure — K | Same layout |
| `alphabet_adventure_l/` | Alphabet Adventure — L | Same layout |
| `alphabet_adventure_m/` | Alphabet Adventure — M | Same layout |
| `alphabet_adventure_n/` | Alphabet Adventure — N | Same layout |
| `alphabet_adventure_o/` | Alphabet Adventure — O | Same layout |
| `alphabet_adventure_p/` | Alphabet Adventure — P | Same layout |
| `alphabet_adventure_q/` | Alphabet Adventure — Q | Same layout |
| `alphabet_adventure_r/` | Alphabet Adventure — R | Same layout |
| `alphabet_adventure_s/` | Alphabet Adventure — S | Same layout |
| `alphabet_adventure_t/` | Alphabet Adventure — T | Same layout |
| `alphabet_adventure_u/` | Alphabet Adventure — U | Same layout |
| `alphabet_adventure_v/` | Alphabet Adventure — V | Same layout |
| `alphabet_adventure_w/` | Alphabet Adventure — W | Same layout |
| `alphabet_adventure_x/` | Alphabet Adventure — X | Same layout |
| `alphabet_adventure_y/` | Alphabet Adventure — Y | Same layout |
| `alphabet_adventure_z/` | Alphabet Adventure — Z | Same layout |

**Template:** All 26 use identical layout — only letter, word, emoji/character asset, and TTS text vary. → **Single parameterized screen.**

### Review, Progress & Celebrations
| Directory | Screen Type | Description |
|-----------|-------------|-------------|
| `alphabet_review_challenge/` | Review game | Mixed letter identification quiz |
| `alphabet_progress_map/` | Progress journey | Visual 26-step path with completion markers |
| `alphabet_completion_celebration/` | Celebration | Animated completion for finishing all 26 |
| `alphabet_sticker_collection/` | Sticker gallery | Per-alphabet sticker collection |

---

## 2. Number Kingdom (15 screens)

### Hub
| Directory | Screen Type | Description |
|-----------|-------------|-------------|
| `number_kingdom/` | Module hub | Number groups overview, tactile cards |
| `number_kingdom_1_10/` | Group hub | Numbers 1-10 detail view |

### Number Group Screens (10 screens)
| Directory | Screen Type |
|-----------|-------------|
| `number_kingdom_1/` | Detail — number 1 theme |
| `number_kingdom_2/` | Detail — number 2 theme |
| `number_kingdom_3/` | Detail — number 3 theme |
| `number_kingdom_4/` | Detail — number 4 theme |
| `number_kingdom_5/` | Detail — number 5 theme |
| `number_kingdom_6/` | Detail — number 6 theme |
| `number_kingdom_7/` | Detail — number 7 theme |
| `number_kingdom_8/` | Detail — number 8 theme |
| `number_kingdom_9/` | Detail — number 9 theme |
| `number_kingdom_10/` | Detail — number 10 theme |

**Pattern:** `squishy-btn` + `tactile-card` + staggered floating animations. Staggered delays (`animate-float-1/2/3`).

### Games, Progress & Rewards
| Directory | Screen Type |
|-----------|-------------|
| `counting_activity_1_5/` | Counting game (1-5) |
| `counting_challenge_6_10/` | Counting game (6-10) |
| `number_progress_map/` | Progress journey |
| `number_kingdom_completion_celebration/` | Celebration |
| `number_reward_golden_star/` | Golden star reward unlock |

---

## 3. Colors World (21 screens)

### Hub
| Directory | Screen Type |
|-----------|-------------|
| `colors_world/` | Module hub |
| `colors_world_remaining_colors/` | Expanded color list |

### Per-Color Detail Screens (11 screens)
| Directory | Gradient Theme |
|-----------|----------------|
| `color_red/` | `from-[#ffb3b3] to-[#ff4d4d]` |
| `color_blue/` | Blue gradient |
| `color_green/` | Green gradient |
| `color_yellow/` | Yellow gradient |
| `color_orange/` | Orange gradient |
| `color_purple/` | Purple gradient |
| `color_pink/` | Pink gradient |
| `color_brown/` | Brown gradient |
| `color_black/` | Dark gradient |
| `color_white/` | Light gradient |
| `colors_reward_screen/` | Color reward/completion |

**Pattern:** Each has paint-splash hero, color-specific gradient background (the only variation). → **Parameterized.**

### Games & Challenges
| Directory | Screen Type | Gameplay |
|-----------|-------------|----------|
| `color_matching_challenge/` | Matching game | Drag colored objects to matching color |
| `color_matching_game/` | Matching game variant | Alternative matching pattern |
| `color_search_challenge/` | Search challenge | Find items of a given color |
| `color_detective_challenge/` | Detective game | Identify color from clues |
| `color_discovery_challenge/` | Discovery game | Explore and find colors |
| `find_the_color_challenge/` | Find challenge | Tap the correct color |
| `color_quiz_arena/` | Quiz | Multiple choice color identification |
| `black_vs_white_sorting_game/` | Sorting game | Sort black vs white objects |
| `green_vs_yellow_sorting_game/` | Sorting game | Sort green vs yellow |
| `orange_vs_purple_sorting_game/` | Sorting game | Sort orange vs purple |
| `pink_vs_brown_sorting_game/` | Sorting game | Sort pink vs brown |
| `orange_purple_celebration/` | Celebration | Mini celebration after sorting game |
| `pink_brown_celebration/` | Celebration | Mini celebration after sorting game |
| `black_white_celebration/` | Celebration | Mini celebration after sorting game |

### Progress & Celebrations
| Directory | Screen Type |
|-----------|-------------|
| `color_explorer_celebration/` | Explorer milestone celebration |
| `color_master_celebration/` | Master celebration |
| `color_master_certificate/` | Completion certificate |
| `color_progress_map/` | Progress journey |
| `color_sticker_collection/` | Color sticker gallery |

---

## 4. Shapes Factory (24 screens)

### Hub
| Directory | Screen Type |
|-----------|-------------|
| `shapes_factory/` | Module hub |
| `shapes_factory_remaining_shapes/` | Extended shape list |

### Per-Shape Detail Screens (8 screens)
| Directory | Shape | Animations |
|-----------|-------|------------|
| `shape_circle/` | Circle | `squish-bounce`, `float-slow`, `float-mascot`, `pulse-ring` |
| `shape_square/` | Square | Same animation set |
| `shape_triangle/` | Triangle | Same |
| `shape_rectangle/` | Rectangle | Same |
| `shape_oval/` | Oval | Same |
| `shape_diamond/` | Diamond | Same |
| `shape_heart/` | Heart | Same |
| `shape_star/` | Star | Same |

**Pattern:** `squish-bounce` keyframe (scale + translateY), `pulse-ring` (scale-out/opacity-fade). → **Parameterized.**

### Games & Workshops
| Directory | Screen Type | Gameplay |
|-----------|-------------|----------|
| `shape_builder_workshop/` | Builder | Drag-and-drop shape construction |
| `shape_puzzle_world/` | Puzzle | Fit shapes into outlines |
| `shape_matching_challenge/` | Matching | Match shapes by type |
| `shape_quiz_arena/` | Quiz | Shape identification quiz |
| `shape_discovery_challenge_1/` | Discovery | Find and learn shapes |
| `shape_discovery_challenge_2/` | Discovery | Advanced shape discovery |
| `shape_hunt_adventure/` | Hunt/Adventure | Find shapes in scenes |
| `shape_hunt_challenge_1/` | Hunt | Shape hunt level 1 |
| `shape_hunt_challenge_2/` | Hunt | Shape hunt level 2 |
| `circle_vs_square_sorting_game/` | Sorting | Sort circles vs squares |
| `triangle_vs_rectangle_sorting_game/` | Sorting | Sort triangles vs rectangles |
| `heart_vs_diamond_sorting_game/` | Sorting | Sort hearts vs diamonds |
| `oval_vs_star_sorting_game/` | Sorting | Sort ovals vs stars |

### Progress & Celebrations
| Directory | Screen Type |
|-----------|-------------|
| `shape_explorer_celebration_1/` | Explorer milestone 1 |
| `shape_explorer_celebration_2/` | Explorer milestone 2 |
| `shape_explorer_celebration_3/` | Explorer milestone 3 |
| `shape_master_celebration/` | Master celebration |
| `shape_master_certificate/` | Completion certificate |
| `shapes_explorer_reward/` | Explorer reward |
| `shape_progress_map/` | Progress journey |
| `shape_sticker_collection/` | Shape sticker gallery |

---

## 5. Days Playground (26 screens)

### Hub
| Directory | Screen Type |
|-----------|-------------|
| `days_playground/` | Module hub — week overview |
| `days_playground_full_week/` | Full week expanded view |

### Per-Day Detail Screens (7 screens)
| Directory | Day | Theme |
|-----------|-----|-------|
| `day_sunday/` | Sunday | Relax/family theme |
| `day_monday/` | Monday | School/learning theme |
| `day_tuesday/` | Tuesday | Activity theme |
| `day_wednesday/` | Wednesday | Mid-week theme |
| `day_thursday/` | Thursday | Preparation theme |
| `day_friday/` | Friday | Celebration eve theme |
| `day_saturday/` | Saturday | Fun/play theme |

**Pattern:** `squishy-btn` + `soft-card` with inset white glow. → **Parameterized.**

### Games & Challenges
| Directory | Screen Type | Gameplay |
|-----------|-------------|----------|
| `day_matching_challenge/` | Matching | Match day names to activities |
| `day_sequencing_challenge/` | Sequencing | Order days correctly |
| `week_builder_game/` | Builder | Build the week in order |
| `week_review_world/` | Review | Review all 7 days |
| `weekly_quiz_arena/` | Quiz | Days of week trivia |
| `monday_vs_tuesday_discovery_game/` | Comparison | Compare Monday vs Tuesday |
| `wednesday_vs_thursday_discovery_game/` | Comparison | Compare Wednesday vs Thursday |
| `friday_vs_saturday_discovery_game/` | Comparison | Compare Friday vs Saturday |

### Progress & Celebrations
| Directory | Screen Type |
|-----------|-------------|
| `days_explorer_celebration_1/` | Explorer milestone 1 |
| `days_explorer_celebration_2/` | Explorer milestone 2 |
| `weekend_explorer_celebration/` | Weekend celebration |
| `week_master_celebration/` | Master celebration |
| `week_master_certificate/` | Completion certificate |
| `weekly_celebration_festival/` | Full week festival |
| `days_completion_hall/` | Completion hall |
| `days_progress_map/` | Progress journey |
| `days_sticker_collection/` | Days sticker gallery |
| `weekly_completion_map/` | Weekly completion map |
| `weekly_journey_map/` | Weekly journey start |
| `weekly_journey_map_update_1/` | Journey milestone 1 |
| `weekly_journey_map_update_2/` | Journey milestone 2 |

---

## 6. Month Explorer (18 screens)

### Hub
| Directory | Screen Type |
|-----------|-------------|
| `month_explorer/` | Module hub — full year overview |
| `month_explorer_full_year/` | Expanded year explorer |

### Per-Month Detail Screens (12 screens)
| Directory | Month | Seasonal Theme |
|-----------|-------|----------------|
| `month_january/` | January | Snow gradient (`snow-gradient`: #f5faff → #c3e8ff) |
| `month_february/` | February | Valentine/hearts theme |
| `month_march/` | March | Spring bloom theme |
| `month_april/` | April | Rain/showers theme |
| `month_may/` | May | Flower/spring theme |
| `month_june/` | June | Summer sun theme |
| `month_july/` | July | Beach/patriotic theme |
| `month_august/` | August | Late summer theme |
| `month_september/` | September | Fall/autumn theme |
| `month_october/` | October | Halloween theme |
| `month_november/` | November | Thanksgiving/harvest theme |
| `month_december/` | December | Christmas/winter theme |

**Pattern:** Each has a unique seasonal gradient background + TopAppBar with back/"ABC Wonder"/smart_toy icon + robot mascot. → **Parameterized with seasonal gradient.**

### Games
| Directory | Screen Type |
|-----------|-------------|
| `month_discovery_game_1/` | Discovery game — seasons |
| `month_discovery_game_2/` | Discovery game — weather matching |
| `month_discovery_game_3/` | Discovery game — month order |
| `month_discovery_game_4/` | Discovery game — holidays |

---

## 7. Rewards System (5 screens)

| Directory | Screen Type | Key UI Features |
|-----------|-------------|-----------------|
| `sticker_museum/` | Sticker museum | Felt texture, scrapbook page, sticker grid (collected/locked), category tabs, zoom overlay, favorite stars, robot helper |
| `achievements_hub/` | Achievements hub | 3D badges (metallic gold/silver), gem gradients (ruby/sapphire/emerald), liquid progress bars |
| `treasure_chest_reward/` | Treasure chest | Animated chest unlock |
| `hall_of_champions/` | Hall of champions | Module mastery showcase |
| `the_big_win/` | Big win | Grand celebration animation |

---

## 8. Robot & Avatar (3 screens)

| Directory | Screen Type | Key Features |
|-----------|-------------|--------------|
| `abc_wonder_robot_mascot/` | Robot mascot | White/blue robot, circular face display, heart eyes, antenna, waving hand, 3D vinyl toy aesthetic |
| `robot_lab/` | Robot lab | Workshop radial gradient background, blueprint dot-grid, glow tubes, robot color/accessory customization |
| `avatar_creation/` | Avatar creator | Child avatar customization |

---

## 9. Parent Dashboard (2 screens)

| Directory | Screen Type | Key Features |
|-----------|-------------|--------------|
| `parent_dashboard/` | Dashboard | Parent gate (math puzzle 6+3=?), bento grid (learning time, daily goal 70%, accuracy 85%, stars 450), weekly bar chart, recent achievements feed, export report, dark mode toggle |
| `parent_progress_dashboard/` | Progress | Detailed per-module breakdown, donut chart (stroke animation), shimmer loading skeletons |

---

## 10. Cross-Module & Misc (44 screens)

### Hubs & Navigation
| Directory | Screen Type |
|-----------|-------------|
| `magical_hub_1/` | Main hub — 2×3 module grid + robot greeting + bottom nav (Play/Learn/Parents) |
| `magical_hub_2/` | Hub variant — alternate layout |

### Daily & Streak
| Directory | Screen Type |
|-----------|-------------|
| `daily_surprise/` | Daily surprise reward |
| `daily_practice_mode/` | Daily practice mode |
| `daily_color_practice/` | Daily color practice |
| `daily_shape_practice/` | Daily shape practice |
| `learning_streak/` | Learning streak tracker |

### Seasonal & Celebrations
| Directory | Screen Type |
|-----------|-------------|
| `seasonal_celebration/` | Seasonal event celebration |
| `grand_seasonal_celebration/` | Grand seasonal celebration |
| `season_explorer_celebration_1/` | Season explorer 1 |
| `season_explorer_celebration_2/` | Season explorer 2 |
| `rainbow_treasure_hunt/` | Rainbow treasure hunt game |
| `night_snow_discovery_challenge/` | Night snow discovery challenge |

### Sessions & Transitions
| Directory | Screen Type |
|-----------|-------------|
| `splash_screen/` | Splash / loading screen |
| `welcome_screen/` | Welcome / onboarding |

### Settings & Config
| Directory | Screen Type |
|-----------|-------------|
| `settings/` | App settings (TTS rate, language, daily limit, reset) |
| `offline_mode/` | Offline mode indicator/screen |
| `magical_toy/` | Magical toy interaction screen |

### Sorting Games (Cross-Module)
| Directory | Screen Type |
|-----------|-------------|
| `black_vs_white_sorting_game/` | Sorting game |
| `green_vs_yellow_sorting_game/` | Sorting game |
| `orange_vs_purple_sorting_game/` | Sorting game |
| `pink_vs_brown_sorting_game/` | Sorting game |
| `circle_vs_square_sorting_game/` | Sorting game |
| `triangle_vs_rectangle_sorting_game/` | Sorting game |
| `heart_vs_diamond_sorting_game/` | Sorting game |
| `oval_vs_star_sorting_game/` | Sorting game |
| `black_white_celebration/` | Mini celebration |
| `orange_purple_celebration/` | Mini celebration |
| `pink_brown_celebration/` | Mini celebration |

---

## Summary Statistics

| Module | Screens | Unique Templates | Parameterized |
|--------|---------|-----------------|---------------|
| Alphabet Adventure | 32 | 6 (hub, detail, review, progress, celebration, sticker) | 26 |
| Number Kingdom | 15 | 7 (hub, group hub, detail×10, counting×2, progress, celebration, reward) | 10 |
| Colors World | 21 | 9 (hub, detail×11, matching×2, search, detective, discovery, find, quiz, sorting×4, celebration×8, progress, sticker) | 11 |
| Shapes Factory | 24 | 10 (hub, detail×8, builder, puzzle, matching, quiz, discovery×2, hunt×3, sorting×4, celebration×6, progress, sticker, reward) | 8 |
| Days Playground | 26 | 10 (hub, detail×7, matching, sequencing, builder, review, quiz, comparison×3, celebration×9, progress×4, sticker) | 7 |
| Month Explorer | 18 | 5 (hub, detail×12, explorer, discovery×4) | 12 |
| Rewards System | 5 | 5 (unique screens) | 0 |
| Robot & Avatar | 3 | 3 (unique screens) | 0 |
| Parent Dashboard | 2 | 2 (unique screens) | 0 |
| Cross-Module | 44 | ~15 (hubs, daily, seasonal, settings, sorting games, sessions) | — |
| **Total** | **188** | **~72 unique templates** | **74 parameterized** |
