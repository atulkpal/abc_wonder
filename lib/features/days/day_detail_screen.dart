import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/data/static/days_data.dart';
import 'package:abc_wonder/data/models/day_model.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class DayDetailScreen extends StatefulWidget {
  final String dayId;
  const DayDetailScreen({super.key, required this.dayId});

  @override
  State<DayDetailScreen> createState() => _DayDetailScreenState();
}

class _DayDetailScreenState extends State<DayDetailScreen> {
  late DayModel _day;

  @override
  void initState() {
    super.initState();
    _day = DaysData.byId(widget.dayId) ?? DaysData.items.first;
  }

  int get _currentIndex => DaysData.items.indexOf(_day);

  void _goDay(int index) {
    final day = DaysData.items[index];
    setState(() => _day = day);
    context.goNamed('day-detail', pathParameters: {'day': day.id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _day.cardColor,
      body: SafeArea(
        child: Column(
          children: [
            _DayDetailTopBar(day: _day),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    Text(_day.emoji, style: const TextStyle(fontSize: 80)),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => TtsHelper().speak(_day.ttsText),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _day.name,
                            style: AppTypography.displayHero.copyWith(
                              color: const Color(0xFF001E2C),
                              fontSize: 40,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.volume_up,
                              color: Color(0xFF001E2C),
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: _day.isWeekend
                            ? Colors.green.withValues(alpha: 0.2)
                            : Colors.blue.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _day.isWeekend ? 'Weekend!' : 'Weekday',
                        style: AppTypography.labelBold.copyWith(
                          color: const Color(0xFF001E2C),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _day.shortName,
                      style: AppTypography.headlineLgMobile.copyWith(
                        color: const Color(0xFF001E2C).withValues(alpha: 0.6),
                        fontSize: 24,
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
            _BeadProgress(currentIndex: _currentIndex, total: DaysData.items.length),
          ],
        ),
      ),
      bottomNavigationBar: _DayBottomNav(
        currentIndex: _currentIndex,
        onBack: () {
          if (_currentIndex > 0) _goDay(_currentIndex - 1);
        },
        onHub: () => context.goNamed('days-hub'),
        onNext: () {
          if (_currentIndex < DaysData.items.length - 1) {
            _goDay(_currentIndex + 1);
          }
        },
      ),
    );
  }
}

class _DayDetailTopBar extends StatelessWidget {
  final DayModel day;
  const _DayDetailTopBar({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF544600), size: 32),
            onPressed: () => context.goNamed('home'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Row(
              children: [
                Text(day.emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    day.name,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.headlineLgMobile.copyWith(
                      color: const Color(0xFF544600),
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy, color: Color(0xFF544600), size: 32),
            onPressed: () => context.goNamed('robot-lab'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _BeadProgress extends StatelessWidget {
  final int currentIndex;
  final int total;

  const _BeadProgress({required this.currentIndex, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (i) {
          final isActive = i == currentIndex;
          final isCompleted = i < currentIndex;
          return Container(
            width: 24,
            height: isActive ? 16 : 12,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFF544600)
                  : isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF544600), width: 1.5),
            ),
          );
        }),
      ),
    );
  }
}

class _DayBottomNav extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onBack;
  final VoidCallback onHub;
  final VoidCallback onNext;

  const _DayBottomNav({
    required this.currentIndex,
    required this.onBack,
    required this.onHub,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 40,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _DetailNavItem(
            icon: Icons.arrow_back,
            label: 'Back',
            onTap: onBack,
            isEnabled: currentIndex > 0,
          ),
          _DetailNavItem(
            icon: Icons.home,
            label: 'Hub',
            onTap: onHub,
          ),
          _DetailNavItem(
            icon: Icons.arrow_forward,
            label: 'Next',
            onTap: onNext,
            isEnabled: currentIndex < DaysData.items.length - 1,
          ),
        ],
      ),
    );
  }
}

class _DetailNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isEnabled;

  const _DetailNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = isEnabled ? const Color(0xFF544600) : Colors.grey;
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.labelBold.copyWith(color: color, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
