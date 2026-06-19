import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/core/monetization/ad_banner_widget.dart';
import 'package:abc_wonder/core/monetization/monetization_service.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            _PDTopBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                children: [
                  const _StatsBentoGrid(),
                  const SizedBox(height: 24),
                  const _WeeklyChart(),
                  const SizedBox(height: 24),
                  const _RecentAchievements(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AdBannerWidget(placementKey: AdPlacements.parentDashboard),
          const _PDBottomNav(),
        ],
      ),
    );
  }
}

class _PDTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        border: Border(bottom: BorderSide(color: Colors.white12)),
      ),
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
              'Parent Dashboard',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white54, size: 28),
            onPressed: () => context.goNamed('parent-settings'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _StatsBentoGrid extends StatelessWidget {
  const _StatsBentoGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 500;
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: _StatCard(icon: Icons.timer, label: 'Learning Time', value: '42 min', color: const Color(0xFF40C4FF))),
                if (isWide) const SizedBox(width: 12),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.flag, label: 'Daily Goal', value: '70%', color: const Color(0xFFFDD400))),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _StatCard(icon: Icons.check_circle, label: 'Avg Accuracy', value: '85%', color: const Color(0xFF7AE07A))),
                if (isWide) const SizedBox(width: 12),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.star, label: 'Stars Earned', value: '450', color: const Color(0xFFFFD700))),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return RimCard(
      backgroundColor: const Color(0xFF16213E),
      borderColor: color.withValues(alpha: 0.4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.white54, fontSize: 12)),
                const SizedBox(height: 2),
                Text(value, style: AppTypography.displayHero.copyWith(color: Colors.white, fontSize: 24)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyChart extends StatefulWidget {
  const _WeeklyChart();

  @override
  State<_WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<_WeeklyChart> {
  final _data = [3.0, 8.0, 5.0, 12.0, 7.0, 15.0, 10.0];
  final _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return RimCard(
      backgroundColor: const Color(0xFF16213E),
      borderColor: Colors.white12,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weekly Activity', style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 4),
            Text('Minutes of learning per day', style: TextStyle(color: Colors.white38, fontSize: 12)),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx < 0 || idx >= _days.length) return const SizedBox();
                          return Text(_days[idx], style: const TextStyle(color: Colors.white38, fontSize: 10));
                        },
                        reservedSize: 22,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}',
                          style: const TextStyle(color: Colors.white38, fontSize: 10),
                        ),
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.white10,
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(_data.length, (i) => BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: _data[i],
                        color: const Color(0xFF40C4FF),
                        width: 16,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        gradient: LinearGradient(
                          colors: [const Color(0xFF40C4FF), const Color(0xFF40C4FF).withValues(alpha: 0.4)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentAchievements extends StatelessWidget {
  const _RecentAchievements();

  @override
  Widget build(BuildContext context) {
    return RimCard(
      backgroundColor: const Color(0xFF16213E),
      borderColor: Colors.white12,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Achievements', style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 12),
            _AchievementRow(emoji: '🎉', label: 'First Letter', detail: 'Completed letter A', time: '2h ago'),
            const Divider(color: Colors.white10, height: 16),
            _AchievementRow(emoji: '⭐', label: 'Count to 10', detail: 'Finished numbers 1-10', time: '1d ago'),
            const Divider(color: Colors.white10, height: 16),
            _AchievementRow(emoji: '🎨', label: 'Color Explorer', detail: 'Explored 5 colors', time: '3d ago'),
          ],
        ),
      ),
    );
  }
}

class _AchievementRow extends StatelessWidget {
  final String emoji;
  final String label;
  final String detail;
  final String time;
  const _AchievementRow({required this.emoji, required this.label, required this.detail, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 15)),
              Text(detail, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ),
        Text(time, style: const TextStyle(color: Colors.white38, fontSize: 11)),
      ],
    );
  }
}

class _PDBottomNav extends StatelessWidget {
  const _PDBottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 40, offset: const Offset(0, -4)),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _PDNavItem(icon: Icons.home, label: 'Hub', onTap: () => context.goNamed('home')),
          _PDNavItem(icon: Icons.auto_awesome_motion, label: 'Stickers', onTap: () => context.goNamed('sticker-museum')),
          _PDNavItem(icon: Icons.smart_toy, label: 'Robot', onTap: () => context.goNamed('robot-lab')),
          _PDNavItem(icon: Icons.card_giftcard, label: 'Daily', onTap: () => context.goNamed('daily-surprise')),
          _PDNavItem(icon: Icons.manage_accounts, label: 'Parents', isActive: true, onTap: () {}),
        ],
      ),
    );
  }
}

class _PDNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _PDNavItem({required this.icon, required this.label, this.isActive = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF40C4FF).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF40C4FF).withValues(alpha: 0.4)),
          ),
          child: Transform.translate(
            offset: const Offset(0, -4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: const Color(0xFF40C4FF), size: 22),
                const SizedBox(height: 2),
                Text(label, style: TextStyle(color: const Color(0xFF40C4FF), fontSize: 11)),
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
            Icon(icon, color: Colors.white38, size: 22),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
