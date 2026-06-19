import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/static/days_data.dart';
import 'package:abc_wonder/data/models/day_model.dart';

class WeekBuilderScreen extends StatefulWidget {
  const WeekBuilderScreen({super.key});

  @override
  State<WeekBuilderScreen> createState() => _WeekBuilderScreenState();
}

class _WeekBuilderScreenState extends State<WeekBuilderScreen> {
  late List<DayModel> _shuffled;
  final List<DayModel> _placed = [];
  int _step = 0;
  bool _complete = false;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    final sorted = List<DayModel>.from(DaysData.items)
      ..sort((a, b) => a.index.compareTo(b.index));
    _shuffled = List.from(sorted)..shuffle();
    _placed.clear();
    _step = 0;
    _complete = false;
  }

  DayModel get _expected => DaysData.items.firstWhere((d) => d.index == _step + 1);

  void _tapDay(DayModel day) {
    if (_complete) {
      _shuffle();
      return;
    }
    if (day.id == _expected.id) {
      setState(() {
        _placed.add(day);
        _shuffled.remove(day);
        _step++;
        if (_step >= 7) _complete = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Try again! Tap ${_expected.name}'),
          duration: const Duration(seconds: 1),
          backgroundColor: const Color(0xFF544600),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _WeekBuilderTopBar(),
            if (_complete)
              _CompletionBanner(onReset: _shuffle)
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Text(
                  'Tap ${_expected.name}',
                  style: AppTypography.headlineLgMobile.copyWith(
                    color: const Color(0xFF544600),
                    fontSize: 22,
                  ),
                ),
              ),
            Expanded(
              flex: 2,
              child: _placed.isEmpty
                  ? const SizedBox.shrink()
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isTablet ? 7 : 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      itemCount: _placed.length,
                      itemBuilder: (_, i) => _DayCard(day: _placed[i], locked: true),
                    ),
            ),
            Expanded(
              flex: 3,
              child: _shuffled.isEmpty
                  ? const SizedBox.shrink()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isTablet ? 7 : 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      itemCount: _shuffled.length,
                      itemBuilder: (_, i) => _DayCard(
                        day: _shuffled[i],
                        onTap: () => _tapDay(_shuffled[i]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekBuilderTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF544600), size: 32),
            onPressed: () => context.goNamed('days-hub'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Week Builder',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: const Color(0xFF544600),
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}

class _CompletionBanner extends StatelessWidget {
  final VoidCallback onReset;
  const _CompletionBanner({required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text('🎉', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          Text(
            'Great job!',
            style: AppTypography.headlineLgMobile.copyWith(
              color: const Color(0xFF544600),
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onReset,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFE66D),
              foregroundColor: const Color(0xFF001E2C),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final DayModel day;
  final VoidCallback? onTap;
  final bool locked;
  const _DayCard({required this.day, this.onTap, this.locked = false});

  @override
  Widget build(BuildContext context) {
    return RimCard(
      onTap: locked ? null : onTap,
      backgroundColor: locked ? const Color(0xFF544600) : day.cardColor,
      borderColor: const Color(0xFF544600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day.emoji, style: TextStyle(fontSize: locked ? 20 : 28)),
          const SizedBox(height: 4),
          Text(
            day.shortName,
            style: AppTypography.labelBold.copyWith(
              color: locked ? Colors.white : const Color(0xFF001E2C),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
