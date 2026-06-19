import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/pressable_3d.dart';
import 'package:abc_wonder/core/widgets/animated_float.dart';
import 'package:abc_wonder/core/gradients/paint_splash_hero.dart';
import 'package:abc_wonder/data/static/color_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class ColorDetailScreen extends StatefulWidget {
  final String colorId;
  const ColorDetailScreen({super.key, required this.colorId});

  @override
  State<ColorDetailScreen> createState() => _ColorDetailScreenState();
}

class _ColorDetailScreenState extends State<ColorDetailScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    final c = ColorData.byId(widget.colorId) ?? ColorData.items[0];
    _currentIndex = ColorData.items.indexOf(c);
  }

  void _goColor(int index) {
    if (index < 0 || index >= ColorData.items.length) return;
    context.goNamed('color-detail', pathParameters: {'color': ColorData.items[index].id});
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorData.items[_currentIndex];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [c.gradientStart, c.gradientEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _ColorDetailTopBar(
                onBack: () => context.goNamed('colors-hub'),
                onRobotTap: () => TtsHelper().speak(c.ttsText),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      PaintSplashHero(label: c.name, splashColor: c.color),
                      const SizedBox(height: 32),
                      Pressable3D(
                        onTap: () => TtsHelper().speak(c.ttsText),
                        child: AnimatedFloat(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: c.color,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: c.color.withValues(alpha: 0.5),
                                  blurRadius: 24,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(c.emoji, style: const TextStyle(fontSize: 48)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        c.hexCode,
                        style: AppTypography.displayHero.copyWith(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _ColorDetailBottomNav(
        currentIndex: _currentIndex,
        total: ColorData.items.length,
        onBack: () => _currentIndex > 0 ? _goColor(_currentIndex - 1) : null,
        onHub: () => context.goNamed('colors-hub'),
        onNext: () {
          if (_currentIndex < ColorData.items.length - 1) {
            _goColor(_currentIndex + 1);
          } else {
            context.goNamed('color-celebration');
          }
        },
      ),
    );
  }
}

class _ColorDetailTopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onRobotTap;
  const _ColorDetailTopBar({required this.onBack, required this.onRobotTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy, color: Colors.white, size: 32),
            onPressed: onRobotTap,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _ColorDetailBottomNav extends StatelessWidget {
  final int currentIndex; final int total; final VoidCallback? onBack; final VoidCallback onHub; final VoidCallback onNext;
  const _ColorDetailBottomNav({required this.currentIndex, required this.total, required this.onBack, required this.onHub, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _CDNavItem(icon: Icons.arrow_back_ios, label: 'Back', onTap: onBack ?? () {}),
          _CDNavItem(icon: Icons.home, label: 'Hub', isActive: true, onTap: onHub),
          _CDNavItem(icon: Icons.arrow_forward_ios, label: currentIndex == total - 1 ? 'Done' : 'Next', onTap: onNext),
        ],
      ),
    );
  }
}

class _CDNavItem extends StatelessWidget {
  final IconData icon; final String label; final bool isActive; final VoidCallback onTap;
  const _CDNavItem({required this.icon, required this.label, this.isActive = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.tertiaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: const Color(0xFF930040), blurRadius: 0, offset: const Offset(0, 4))],
          ),
          child: Transform.translate(
            offset: const Offset(0, -4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppColors.onTertiaryContainer, size: 28),
                const SizedBox(height: 4),
                Text(label, style: AppTypography.labelBold.copyWith(color: AppColors.onTertiaryContainer, fontSize: 18)),
              ],
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.black38, size: 28),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.labelBold.copyWith(color: Colors.black38, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
