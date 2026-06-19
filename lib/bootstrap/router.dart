import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:abc_wonder/features/splash/splash_screen.dart';
import 'package:abc_wonder/features/home/home_screen.dart';
import 'package:abc_wonder/features/alphabet/alphabet_hub_screen.dart';
import 'package:abc_wonder/features/alphabet/alphabet_detail_screen.dart';
import 'package:abc_wonder/features/alphabet/alphabet_review_screen.dart';
import 'package:abc_wonder/features/alphabet/alphabet_celebration_screen.dart';
import 'package:abc_wonder/features/numbers/number_hub_screen.dart';
import 'package:abc_wonder/features/numbers/number_detail_screen.dart';
import 'package:abc_wonder/features/numbers/number_quiz_screen.dart';
import 'package:abc_wonder/features/numbers/counting_game_screen.dart';
import 'package:abc_wonder/features/numbers/number_celebration_screen.dart';
import 'package:abc_wonder/features/colors/colors_hub_screen.dart';
import 'package:abc_wonder/features/colors/color_detail_screen.dart';
import 'package:abc_wonder/features/colors/color_matching_screen.dart';
import 'package:abc_wonder/features/colors/color_search_screen.dart';
import 'package:abc_wonder/features/colors/color_quiz_screen.dart';
import 'package:abc_wonder/features/colors/color_celebration_screen.dart';
import 'package:abc_wonder/features/shapes/shapes_hub_screen.dart';
import 'package:abc_wonder/features/shapes/shape_detail_screen.dart';
import 'package:abc_wonder/features/shapes/shape_builder_screen.dart';
import 'package:abc_wonder/features/shapes/shape_puzzle_screen.dart';
import 'package:abc_wonder/features/shapes/shape_hunt_screen.dart';
import 'package:abc_wonder/features/shapes/shape_celebration_screen.dart';
import 'package:abc_wonder/features/days/days_hub_screen.dart';
import 'package:abc_wonder/features/days/day_detail_screen.dart';
import 'package:abc_wonder/features/days/week_builder_screen.dart';
import 'package:abc_wonder/features/days/daily_quiz_screen.dart';
import 'package:abc_wonder/features/months/months_hub_screen.dart';
import 'package:abc_wonder/features/months/month_detail_screen.dart';
import 'package:abc_wonder/features/months/full_year_explorer_screen.dart';
import 'package:abc_wonder/features/rewards/sticker_museum_screen.dart';
import 'package:abc_wonder/features/rewards/achievements_hub_screen.dart';
import 'package:abc_wonder/features/rewards/treasure_chest_screen.dart';
import 'package:abc_wonder/features/rewards/hall_of_champions_screen.dart';
import 'package:abc_wonder/features/robot/robot_lab_screen.dart';
import 'package:abc_wonder/features/parent_dashboard/parent_dashboard_screen.dart';
import 'package:abc_wonder/features/parent_dashboard/parent_progress_screen.dart';
import 'package:abc_wonder/features/parent_dashboard/parent_settings_screen.dart';
import 'package:abc_wonder/core/monetization/parent_gate.dart';
import 'package:abc_wonder/features/daily/daily_surprise_screen.dart';
import 'package:abc_wonder/features/settings/settings_screen.dart';
import 'package:abc_wonder/features/style_guide/style_guide_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/alphabet',
      name: 'alphabet-hub',
      builder: (context, state) => const AlphabetHubScreen(),
      routes: [
        GoRoute(
          path: ':letter',
          name: 'alphabet-detail',
          builder: (context, state) {
            final letter = state.pathParameters['letter'] ?? 'A';
            return AlphabetDetailScreen(letterId: letter);
          },
        ),
        GoRoute(
          path: 'review',
          name: 'alphabet-review',
          builder: (context, state) => const AlphabetReviewScreen(),
        ),
        GoRoute(
          path: 'celebration',
          name: 'alphabet-celebration',
          builder: (context, state) => const AlphabetCelebrationScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/numbers',
      name: 'numbers-hub',
      builder: (context, state) => const NumberHubScreen(),
      routes: [
        GoRoute(
          path: ':number',
          name: 'number-detail',
          builder: (context, state) {
            final numStr = state.pathParameters['number'] ?? '1';
            return NumberDetailScreen(numberId: numStr);
          },
        ),
        GoRoute(
          path: 'quiz',
          name: 'number-quiz',
          builder: (context, state) => const NumberQuizScreen(),
        ),
        GoRoute(
          path: 'counting',
          name: 'counting-game',
          builder: (context, state) => const CountingGameScreen(),
        ),
        GoRoute(
          path: 'celebration',
          name: 'number-celebration',
          builder: (context, state) => const NumberCelebrationScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/colors',
      name: 'colors-hub',
      builder: (context, state) => const ColorsHubScreen(),
      routes: [
        GoRoute(
          path: ':color',
          name: 'color-detail',
          builder: (context, state) {
            final colorId = state.pathParameters['color'] ?? 'red';
            return ColorDetailScreen(colorId: colorId);
          },
        ),
        GoRoute(
          path: 'matching',
          name: 'color-matching',
          builder: (context, state) => const ColorMatchingScreen(),
        ),
        GoRoute(
          path: 'search',
          name: 'color-search',
          builder: (context, state) => const ColorSearchScreen(),
        ),
        GoRoute(
          path: 'quiz',
          name: 'color-quiz',
          builder: (context, state) => const ColorQuizScreen(),
        ),
        GoRoute(
          path: 'celebration',
          name: 'color-celebration',
          builder: (context, state) => const ColorCelebrationScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/shapes',
      name: 'shapes-hub',
      builder: (context, state) => const ShapesHubScreen(),
      routes: [
        GoRoute(
          path: ':shape',
          name: 'shape-detail',
          builder: (context, state) {
            final shapeId = state.pathParameters['shape'] ?? 'circle';
            return ShapeDetailScreen(shapeId: shapeId);
          },
        ),
        GoRoute(
          path: 'builder',
          name: 'shape-builder',
          builder: (context, state) => const ShapeBuilderScreen(),
        ),
        GoRoute(
          path: 'puzzle',
          name: 'shape-puzzle',
          builder: (context, state) => const ShapePuzzleScreen(),
        ),
        GoRoute(
          path: 'hunt',
          name: 'shape-hunt',
          builder: (context, state) => const ShapeHuntScreen(),
        ),
        GoRoute(
          path: 'celebration',
          name: 'shape-celebration',
          builder: (context, state) => const ShapeCelebrationScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/days',
      name: 'days-hub',
      builder: (context, state) => const DaysHubScreen(),
      routes: [
        GoRoute(
          path: ':day',
          name: 'day-detail',
          builder: (context, state) {
            final dayId = state.pathParameters['day'] ?? 'monday';
            return DayDetailScreen(dayId: dayId);
          },
        ),
        GoRoute(
          path: 'builder',
          name: 'week-builder',
          builder: (context, state) => const WeekBuilderScreen(),
        ),
        GoRoute(
          path: 'quiz',
          name: 'daily-quiz',
          builder: (context, state) => const DailyQuizScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/months',
      name: 'months-hub',
      builder: (context, state) => const MonthsHubScreen(),
      routes: [
        GoRoute(
          path: ':month',
          name: 'month-detail',
          builder: (context, state) {
            final monthId = state.pathParameters['month'] ?? 'january';
            return MonthDetailScreen(monthId: monthId);
          },
        ),
        GoRoute(
          path: 'explorer',
          name: 'full-year-explorer',
          builder: (context, state) => const FullYearExplorerScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/stickers',
      name: 'sticker-museum',
      builder: (context, state) => const StickerMuseumScreen(),
    ),
    GoRoute(
      path: '/achievements',
      name: 'achievements-hub',
      builder: (context, state) => const AchievementsHubScreen(),
    ),
    GoRoute(
      path: '/treasure',
      name: 'treasure-chest',
      builder: (context, state) => const TreasureChestScreen(),
    ),
    GoRoute(
      path: '/champions',
      name: 'hall-of-champions',
      builder: (context, state) => const HallOfChampionsScreen(),
    ),
    GoRoute(
      path: '/robot-lab',
      name: 'robot-lab',
      builder: (context, state) => const RobotLabScreen(),
    ),
    GoRoute(
      path: '/parent',
      name: 'parent-dashboard',
      builder: (context, state) => const ParentGatedWidget(
        child: ParentDashboardScreen(),
      ),
      routes: [
        GoRoute(
          path: 'progress',
          name: 'parent-progress',
          builder: (context, state) => const ParentProgressScreen(),
        ),
        GoRoute(
          path: 'settings',
          name: 'parent-settings',
          builder: (context, state) => const ParentSettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/daily',
      name: 'daily-surprise',
      builder: (context, state) => const DailySurpriseScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/style-guide',
      name: 'style-guide',
      builder: (context, state) => const StyleGuideScreen(),
    ),
  ],
);
