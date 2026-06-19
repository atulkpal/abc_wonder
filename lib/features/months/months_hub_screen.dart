import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/core/monetization/ad_banner_widget.dart';
import 'package:abc_wonder/core/monetization/monetization_service.dart';
import 'package:abc_wonder/data/static/months_data.dart';
import 'package:abc_wonder/data/models/month_model.dart';

class MonthsHubScreen extends StatelessWidget {
  const MonthsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _MonthsTopBar(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 6 : 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: MonthsData.items.length,
                itemBuilder: (context, index) {
                  final month = MonthsData.items[index];
                  return _MonthCard(month: month);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AdBannerWidget(placementKey: AdPlacements.monthsHub),
          _MonthsBottomNav(),
        ],
      ),
    );
  }
}

class _MonthsTopBar extends StatelessWidget {
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
            icon: const Icon(Icons.arrow_back, color: Color(0xFF3F0018), size: 32),
            onPressed: () => context.goNamed('home'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Month Explorer',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: const Color(0xFF3F0018),
                fontSize: 28,
              ),
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

class _MonthCard extends StatelessWidget {
  final MonthModel month;
  const _MonthCard({required this.month});

  @override
  Widget build(BuildContext context) {
    return RimCard(
      onTap: () => context.goNamed('month-detail', pathParameters: {'month': month.id}),
      backgroundColor: month.cardColor,
      borderColor: const Color(0xFF3F0018),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(month.emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Text(
            month.shortName,
            style: AppTypography.labelBold.copyWith(
              color: const Color(0xFF001E2C),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthsBottomNav extends StatelessWidget {
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
          _MNavItem(
            icon: Icons.calendar_month,
            label: 'Explore',
            onTap: () => context.goNamed('full-year-explorer'),
          ),
          _MNavItem(
            icon: Icons.home,
            label: 'Hub',
            isActive: true,
            onTap: () {},
          ),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}

class _MNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MNavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD9DF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3F0018),
                blurRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Transform.translate(
            offset: const Offset(0, -4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: const Color(0xFF001E2C), size: 28),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: AppTypography.labelBold.copyWith(
                    color: const Color(0xFF001E2C),
                    fontSize: 18,
                  ),
                ),
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
            Text(
              label,
              style: AppTypography.labelBold.copyWith(
                color: AppColors.onSurfaceVariant,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
