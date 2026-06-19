import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/pressable_3d.dart';
import 'package:abc_wonder/core/widgets/animated_float.dart';
import 'package:abc_wonder/data/static/number_data.dart';
import 'package:abc_wonder/data/models/number_model.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class NumberDetailScreen extends StatefulWidget {
  final String numberId;
  const NumberDetailScreen({super.key, required this.numberId});

  @override
  State<NumberDetailScreen> createState() => _NumberDetailScreenState();
}

class _NumberDetailScreenState extends State<NumberDetailScreen> {
  late NumberModel _number;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _number = NumberData.byId(widget.numberId) ?? NumberData.items[0];
    _currentIndex = NumberData.items.indexOf(_number);
  }

  void _goNumber(int index) {
    if (index < 0 || index >= NumberData.items.length) return;
    final next = NumberData.items[index];
    context.goNamed('number-detail', pathParameters: {'number': next.id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _NumberDetailTopBar(
              onBack: () => context.goNamed('numbers-hub'),
              onRobotTap: () => TtsHelper().speak(_number.ttsText),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        Pressable3D(
                          onTap: () => TtsHelper().speak(_number.ttsText),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryContainer,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6F5C00).withValues(alpha: 0.3),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                _number.id,
                                style: AppTypography.displayHero.copyWith(
                                  color: AppColors.onSecondaryContainer,
                                  fontSize: 56,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _number.spokenName,
                          style: AppTypography.headlineLg.copyWith(
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 32),
                        AnimatedFloat(
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: List.generate(
                              _number.value,
                              (i) => Text(_number.emoji, style: const TextStyle(fontSize: 40)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Pressable3D(
                          onTap: () => TtsHelper().speak(_number.spokenName),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryContainer,
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.secondary.withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Count: ${_number.value}',
                                  style: AppTypography.bodyXl.copyWith(
                                    color: AppColors.onSecondaryContainer,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.volume_up, color: Colors.white, size: 28),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _NumberDetailBottomNav(
        currentIndex: _currentIndex,
        total: NumberData.items.length,
        onBack: () => _currentIndex > 0 ? _goNumber(_currentIndex - 1) : null,
        onHub: () => context.goNamed('numbers-hub'),
        onNext: () {
          if (_currentIndex < NumberData.items.length - 1) {
            _goNumber(_currentIndex + 1);
          } else {
            context.goNamed('number-celebration');
          }
        },
      ),
    );
  }
}

class _NumberDetailTopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onRobotTap;
  const _NumberDetailTopBar({required this.onBack, required this.onRobotTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: AppColors.onSurface.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.arrow_back, color: AppColors.secondary, size: 32), onPressed: onBack, padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
          Flexible(child: Text('Number Kingdom', overflow: TextOverflow.ellipsis, style: AppTypography.headlineLgMobile.copyWith(color: AppColors.secondary, fontSize: 28))),
          IconButton(icon: Icon(Icons.smart_toy, color: AppColors.secondary, size: 32), onPressed: onRobotTap, padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
        ],
      ),
    );
  }
}

class _NumberDetailBottomNav extends StatelessWidget {
  final int currentIndex;
  final int total;
  final VoidCallback? onBack;
  final VoidCallback onHub;
  final VoidCallback onNext;
  const _NumberDetailBottomNav({required this.currentIndex, required this.total, required this.onBack, required this.onHub, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), blurRadius: 40, offset: const Offset(0, -4))],
      ),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NumberDetailNavItem(icon: Icons.arrow_back_ios, label: 'Back', onTap: onBack ?? () {}),
          _NumberDetailNavItem(icon: Icons.home, label: 'Hub', isActive: true, onTap: onHub),
          _NumberDetailNavItem(icon: Icons.arrow_forward_ios, label: currentIndex == total - 1 ? 'Done' : 'Next', onTap: onNext),
        ],
      ),
    );
  }
}

class _NumberDetailNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _NumberDetailNavItem({required this.icon, required this.label, this.isActive = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: const Color(0xFF6F5C00), blurRadius: 0, offset: const Offset(0, 4))],
          ),
          child: Transform.translate(
            offset: const Offset(0, -4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppColors.onSecondaryContainer, size: 28),
                const SizedBox(height: 4),
                Text(label, style: AppTypography.labelBold.copyWith(color: AppColors.onSecondaryContainer, fontSize: 18)),
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
            Icon(icon, color: AppColors.onSurfaceVariant, size: 28),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.labelBold.copyWith(color: AppColors.onSurfaceVariant, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
