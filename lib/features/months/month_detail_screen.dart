import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/data/static/months_data.dart';
import 'package:abc_wonder/data/models/month_model.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class MonthDetailScreen extends StatefulWidget {
  final String monthId;
  const MonthDetailScreen({super.key, required this.monthId});

  @override
  State<MonthDetailScreen> createState() => _MonthDetailScreenState();
}

class _MonthDetailScreenState extends State<MonthDetailScreen> {
  late MonthModel _month;

  @override
  void initState() {
    super.initState();
    _month = MonthsData.byId(widget.monthId) ?? MonthsData.items.first;
  }

  int get _currentIndex => MonthsData.items.indexOf(_month);

  void _goMonth(int index) {
    final month = MonthsData.items[index];
    setState(() => _month = month);
    context.goNamed('month-detail', pathParameters: {'month': month.id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_month.seasonGradientStart, _month.seasonGradientEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _MonthDetailTopBar(month: _month),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      Text(_month.emoji, style: const TextStyle(fontSize: 80)),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () => TtsHelper().speak(_month.ttsText),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _month.name,
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
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Season: ${_month.season}',
                          style: AppTypography.labelBold.copyWith(
                            color: const Color(0xFF001E2C),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Month ${_month.index} of 12',
                          style: AppTypography.labelBold.copyWith(
                            color: const Color(0xFF001E2C).withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
              _BeadProgress(currentIndex: _currentIndex, total: MonthsData.items.length),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _MonthBottomNav(
        currentIndex: _currentIndex,
        onBack: () {
          if (_currentIndex > 0) _goMonth(_currentIndex - 1);
        },
        onHub: () => context.goNamed('months-hub'),
        onNext: () {
          if (_currentIndex < MonthsData.items.length - 1) {
            _goMonth(_currentIndex + 1);
          }
        },
      ),
    );
  }
}

class _MonthDetailTopBar extends StatelessWidget {
  final MonthModel month;
  const _MonthDetailTopBar({required this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF3F0018), size: 32),
            onPressed: () => context.goNamed('home'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Row(
              children: [
                Text(month.emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    month.name,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.headlineLgMobile.copyWith(
                      color: const Color(0xFF3F0018),
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy, color: Color(0xFF3F0018), size: 32),
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
            width: 20,
            height: isActive ? 16 : 12,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFF3F0018)
                  : isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF3F0018), width: 1.5),
            ),
          );
        }),
      ),
    );
  }
}

class _MonthBottomNav extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onBack;
  final VoidCallback onHub;
  final VoidCallback onNext;

  const _MonthBottomNav({
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
          _MDetailNavItem(
            icon: Icons.arrow_back,
            label: 'Back',
            onTap: onBack,
            isEnabled: currentIndex > 0,
          ),
          _MDetailNavItem(
            icon: Icons.home,
            label: 'Hub',
            onTap: onHub,
          ),
          _MDetailNavItem(
            icon: Icons.arrow_forward,
            label: 'Next',
            onTap: onNext,
            isEnabled: currentIndex < MonthsData.items.length - 1,
          ),
        ],
      ),
    );
  }
}

class _MDetailNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isEnabled;

  const _MDetailNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = isEnabled ? const Color(0xFF3F0018) : Colors.grey;
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
