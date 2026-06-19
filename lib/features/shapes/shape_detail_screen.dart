import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/pressable_3d.dart';
import 'package:abc_wonder/core/widgets/pulse_ring.dart';
import 'package:abc_wonder/data/static/shape_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class ShapeDetailScreen extends StatefulWidget {
  final String shapeId;
  const ShapeDetailScreen({super.key, required this.shapeId});

  @override
  State<ShapeDetailScreen> createState() => _ShapeDetailScreenState();
}

class _ShapeDetailScreenState extends State<ShapeDetailScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    final s = ShapeData.byId(widget.shapeId) ?? ShapeData.items[0];
    _currentIndex = ShapeData.items.indexOf(s);
  }

  void _goShape(int index) {
    if (index < 0 || index >= ShapeData.items.length) return;
    context.goNamed('shape-detail', pathParameters: {'shape': ShapeData.items[index].id});
  }

  @override
  Widget build(BuildContext context) {
    final s = ShapeData.items[_currentIndex];
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _ShapeDetailTopBar(onBack: () => context.goNamed('shapes-hub'), onRobotTap: () => TtsHelper().speak(s.ttsText)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
                child: Column(
                  children: [
                    PulseRing(
                      onTap: () => TtsHelper().speak(s.ttsText),
                      child: Container(
                        width: 160, height: 160,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7AD0FF),
                          borderRadius: BorderRadius.circular(s.id == 'circle' || s.id == 'oval' ? 80 : 24),
                          boxShadow: [BoxShadow(color: const Color(0xFF00668A).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8))],
                        ),
                        child: Center(child: Text(s.emoji, style: const TextStyle(fontSize: 64))),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(s.name, style: AppTypography.displayHero.copyWith(color: const Color(0xFF00668A), fontSize: 40)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7AD0FF).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        s.sides == 0 ? 'Round shape, no corners' : '${s.sides} sides, ${s.hasCorners ? 'has' : 'no'} corners',
                        style: AppTypography.bodyXl.copyWith(color: const Color(0xFF004E6B)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Pressable3D(
                      onTap: () => TtsHelper().speak(s.ttsText),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7AD0FF),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.volume_up, color: Colors.white, size: 28),
                          const SizedBox(width: 8),
                          Text('Say it', style: AppTypography.labelBold.copyWith(color: Colors.white)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _ShapeDetailBottomNav(
        currentIndex: _currentIndex, total: ShapeData.items.length,
        onBack: () => _currentIndex > 0 ? _goShape(_currentIndex - 1) : null,
        onHub: () => context.goNamed('shapes-hub'),
        onNext: () {
          if (_currentIndex < ShapeData.items.length - 1) {
            _goShape(_currentIndex + 1);
          } else {
            context.goNamed('shape-celebration');
          }
        },
      ),
    );
  }
}

class _ShapeDetailTopBar extends StatelessWidget {
  final VoidCallback onBack; final VoidCallback onRobotTap;
  const _ShapeDetailTopBar({required this.onBack, required this.onRobotTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64, padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: AppColors.onSurface.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(icon: Icon(Icons.arrow_back, color: const Color(0xFF00668A), size: 32), onPressed: onBack, padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
        Flexible(child: Text('Shapes Factory', overflow: TextOverflow.ellipsis, style: AppTypography.headlineLgMobile.copyWith(color: const Color(0xFF00668A), fontSize: 28))),
        IconButton(icon: Icon(Icons.smart_toy, color: const Color(0xFF00668A), size: 32), onPressed: onRobotTap, padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
      ]),
    );
  }
}

class _ShapeDetailBottomNav extends StatelessWidget {
  final int currentIndex; final int total; final VoidCallback? onBack; final VoidCallback onHub; final VoidCallback onNext;
  const _ShapeDetailBottomNav({required this.currentIndex, required this.total, required this.onBack, required this.onHub, required this.onNext});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.surfaceContainer, borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), blurRadius: 40, offset: const Offset(0, -4))]),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _SDNavItem(icon: Icons.arrow_back_ios, label: 'Back', onTap: onBack ?? () {}),
        _SDNavItem(icon: Icons.home, label: 'Hub', isActive: true, onTap: onHub),
        _SDNavItem(icon: Icons.arrow_forward_ios, label: currentIndex == total - 1 ? 'Done' : 'Next', onTap: onNext),
      ]),
    );
  }
}

class _SDNavItem extends StatelessWidget {
  final IconData icon; final String label; final bool isActive; final VoidCallback onTap;
  const _SDNavItem({required this.icon, required this.label, this.isActive = false, required this.onTap});
  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GestureDetector(onTap: onTap, child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFF7AD0FF), borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: const Color(0xFF004E6B), blurRadius: 0, offset: const Offset(0, 4))]),
        child: Transform.translate(offset: const Offset(0, -4), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: const Color(0xFF001E2C), size: 28), const SizedBox(height: 4),
          Text(label, style: AppTypography.labelBold.copyWith(color: const Color(0xFF001E2C), fontSize: 18)),
        ])),
      ));
    }
    return GestureDetector(onTap: onTap, child: Padding(padding: const EdgeInsets.all(8), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: AppColors.onSurfaceVariant, size: 28), const SizedBox(height: 4),
      Text(label, style: AppTypography.labelBold.copyWith(color: AppColors.onSurfaceVariant, fontSize: 18)),
    ])));
  }
}
