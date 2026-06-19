import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';

class HallOfChampionsScreen extends StatelessWidget {
  const HallOfChampionsScreen({super.key});

  static const _modules = [
    _ModuleData('Alphabet', 'Adventure', '🍎', Color(0xFF40C4FF), 0.75, 26),
    _ModuleData('Number', 'Kingdom', '🔢', Color(0xFFFDD400), 0.5, 100),
    _ModuleData('Colors', 'World', '🎨', Color(0xFFFF9BB2), 0.25, 11),
    _ModuleData('Shapes', 'Factory', '⬜', Color(0xFF7AD0FF), 0.83, 8),
    _ModuleData('Days', 'Playground', '📅', Color(0xFFFFE66D), 1.0, 7),
    _ModuleData('Months', 'Explorer', '🌙', Color(0xFFFFD9DF), 0.33, 12),
  ];

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: Column(
          children: [
            _ChampionTopBar(),
            const SizedBox(height: 16),
            _ChampionHeader(modules: _modules),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: _modules.length,
                itemBuilder: (_, i) => _ModuleChampionCard(data: _modules[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleData {
  final String title;
  final String subtitle;
  final String emoji;
  final Color color;
  final double progress;
  final int items;
  const _ModuleData(this.title, this.subtitle, this.emoji, this.color, this.progress, this.items);
}

class _ChampionTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
            onPressed: () => context.goNamed('home'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Hall of Champions',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy, color: Colors.white, size: 32),
            onPressed: () => context.goNamed('robot-lab'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _ChampionHeader extends StatelessWidget {
  final List<_ModuleData> modules;
  const _ChampionHeader({required this.modules});

  @override
  Widget build(BuildContext context) {
    final completed = modules.where((m) => m.progress >= 1.0).length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Text('🏆', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          Text(
            completed == modules.length ? 'Grand Champion!' : 'Keep Going!',
            style: AppTypography.displayHero.copyWith(
              color: Colors.amber,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$completed of ${modules.length} modules mastered',
            style: AppTypography.labelBold.copyWith(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: completed / modules.length,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleChampionCard extends StatelessWidget {
  final _ModuleData data;
  const _ModuleChampionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final isCompleted = data.progress >= 1.0;
    return RimCard(
      backgroundColor: data.color.withValues(alpha: 0.15),
      borderColor: isCompleted ? Colors.amber : Colors.white24,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data.emoji, style: const TextStyle(fontSize: 32)),
                if (isCompleted)
                  const Icon(Icons.check_circle, color: Colors.amber, size: 24)
                else
                  Text(
                    '${(data.progress * 100).toInt()}%',
                    style: AppTypography.labelBold.copyWith(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Text(
              data.title,
              style: AppTypography.labelBold.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              data.subtitle,
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: data.progress,
                backgroundColor: Colors.white12,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isCompleted ? Colors.amber : Colors.white,
                ),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${(data.progress * data.items).toInt()}/${data.items}',
              style: TextStyle(color: Colors.white38, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
