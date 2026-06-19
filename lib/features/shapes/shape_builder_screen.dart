import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/static/shape_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class ShapeBuilderScreen extends StatefulWidget {
  const ShapeBuilderScreen({super.key});

  @override
  State<ShapeBuilderScreen> createState() => _ShapeBuilderScreenState();
}

class _ShapeBuilderScreenState extends State<ShapeBuilderScreen> {
  final List<String> _palette = [];

  void _addShape(String shapeId) {
    setState(() => _palette.add(shapeId));
    TtsHelper().speak(ShapeData.byId(shapeId)?.name ?? '');
    if (_palette.length >= 3) {
      TtsHelper().speak('Great building!');
    }
  }

  void _clear() => setState(() => _palette.clear());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Shape Builder'),
        backgroundColor: const Color(0xFF7AD0FF),
        foregroundColor: const Color(0xFF001E2C),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.goNamed('shapes-hub')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Tap shapes to build your design!', style: AppTypography.bodyXl.copyWith(color: AppColors.onSurfaceVariant)),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outlineVariant, width: 2),
              ),
              child: Center(
                child: _palette.isEmpty
                    ? Text('Your canvas', style: AppTypography.headlineLg.copyWith(color: AppColors.outline))
                    : Wrap(
                        spacing: 8, runSpacing: 8,
                        children: _palette.map((id) {
                          final s = ShapeData.byId(id)!;
                          return Container(
                            width: 60, height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7AD0FF),
                              borderRadius: BorderRadius.circular(s.id == 'circle' || s.id == 'oval' ? 30 : 8),
                            ),
                            child: Center(child: Text(s.emoji, style: const TextStyle(fontSize: 28))),
                          );
                        }).toList(),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: ShapeData.items.map((s) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: RimCard(
                    onTap: () => _addShape(s.id),
                    backgroundColor: const Color(0xFF7AD0FF),
                    borderColor: const Color(0xFF004E6B),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(s.emoji, style: const TextStyle(fontSize: 24)),
                        Text(s.name, style: const TextStyle(fontSize: 10, color: Color(0xFF001E2C))),
                      ]),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Row(
              children: [
                Expanded(
                  child: RimCard(
                    onTap: _clear,
                    backgroundColor: AppColors.surfaceVariant,
                    borderColor: AppColors.outline,
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(child: Text('Clear', style: TextStyle(fontSize: 16, color: Colors.black54))),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: RimCard(
                    onTap: () => context.goNamed('shape-celebration'),
                    backgroundColor: const Color(0xFF7AD0FF),
                    borderColor: const Color(0xFF004E6B),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(child: Text('Done!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF001E2C)))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
