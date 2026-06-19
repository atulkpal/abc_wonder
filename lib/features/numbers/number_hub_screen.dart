import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/static/number_data.dart';
import 'package:abc_wonder/core/monetization/ad_banner_widget.dart';
import 'package:abc_wonder/core/monetization/monetization_service.dart';

class NumberHubScreen extends StatelessWidget {
  const NumberHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _NumberTopBar(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = isTablet ? 5 : 3;
                  final itemCount = NumberData.items.length;
                  final fillers = (crossAxisCount - itemCount % crossAxisCount) % crossAxisCount;
                  final displayCount = itemCount + fillers;
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemCount: displayCount,
                    itemBuilder: (context, index) {
                      if (index >= itemCount) {
                        return const SizedBox.shrink();
                      }
                      final number = NumberData.items[index];
                      return RimCard(
                        onTap: () => context.goNamed('number-detail',
                            pathParameters: {'number': number.id}),
                        backgroundColor: AppColors.secondaryContainer,
                        borderColor: const Color(0xFF6F5C00),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                number.id,
                                style: AppTypography.displayHero.copyWith(
                                  color: AppColors.onSecondaryContainer,
                                  fontSize: 28,
                                ),
                              ),
                              Text(
                                number.emoji,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AdBannerWidget(placementKey: AdPlacements.numberHub),
          _NumberBottomNav(),
        ],
      ),
    );
  }
}

class _NumberTopBar extends StatelessWidget {
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
            icon: Icon(Icons.arrow_back, color: AppColors.secondary, size: 32),
            onPressed: () => context.goNamed('home'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Number Kingdom',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: AppColors.secondary,
                fontSize: 28,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.smart_toy, color: AppColors.secondary, size: 32),
            onPressed: () => context.goNamed('robot-lab'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _NumberBottomNav extends StatelessWidget {
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
          _NumberNavItem(
            icon: Icons.play_circle,
            label: 'Counting',
            onTap: () => context.goNamed('counting-game'),
          ),
          _NumberNavItem(
            icon: Icons.home,
            label: 'Hub',
            isActive: true,
            onTap: () {},
          ),
          _NumberNavItem(
            icon: Icons.quiz,
            label: 'Quiz',
            onTap: () => context.goNamed('number-quiz'),
          ),
        ],
      ),
    );
  }
}

class _NumberNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _NumberNavItem({
    required this.icon, required this.label,
    this.isActive = false, required this.onTap,
  });

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
