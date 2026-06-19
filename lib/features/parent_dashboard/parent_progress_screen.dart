import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';

class ParentProgressScreen extends StatelessWidget {
  const ParentProgressScreen({super.key});

  static const _modules = [
    _ModuleProg('Alphabet Adventure', 0.75, 20, 26, Color(0xFF40C4FF), '🍎'),
    _ModuleProg('Number Kingdom', 0.5, 50, 100, Color(0xFFFDD400), '🔢'),
    _ModuleProg('Colors World', 0.25, 3, 11, Color(0xFFFF9BB2), '🎨'),
    _ModuleProg('Shapes Factory', 0.83, 7, 8, Color(0xFF7AD0FF), '⬜'),
    _ModuleProg('Days Playground', 1.0, 7, 7, Color(0xFFFFE66D), '📅'),
    _ModuleProg('Month Explorer', 0.33, 4, 12, Color(0xFFFFD9DF), '🌙'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            _PPTopBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  Text('Detailed Progress', style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                itemCount: _modules.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _ModuleProgressCard(data: _modules[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PPTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64, padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(color: Color(0xFF1A1A2E), border: Border(bottom: BorderSide(color: Colors.white12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32), onPressed: () => context.goNamed('parent-dashboard'), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
          Flexible(child: Text('Progress', overflow: TextOverflow.ellipsis, style: AppTypography.headlineLgMobile.copyWith(color: Colors.white, fontSize: 28))),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}

class _ModuleProg {
  final String name;
  final double progress;
  final int completed;
  final int total;
  final Color color;
  final String emoji;
  const _ModuleProg(this.name, this.progress, this.completed, this.total, this.color, this.emoji);
}

class _ModuleProgressCard extends StatelessWidget {
  final _ModuleProg data;
  const _ModuleProgressCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return RimCard(
      backgroundColor: const Color(0xFF16213E),
      borderColor: data.color.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(data.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name, style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: data.progress,
                      backgroundColor: Colors.white12,
                      valueColor: AlwaysStoppedAnimation<Color>(data.color),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${data.completed}/${data.total} items', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                      Text('${(data.progress * 100).toInt()}%', style: TextStyle(color: data.color, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
