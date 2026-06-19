import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/data/static/color_data.dart';
import 'package:abc_wonder/core/monetization/ad_banner_widget.dart';
import 'package:abc_wonder/core/monetization/monetization_service.dart';

class ColorsHubScreen extends StatelessWidget {
  const ColorsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _ColorsTopBar(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 4 : 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: ColorData.items.length,
                itemBuilder: (context, index) {
                  final c = ColorData.items[index];
                  return GestureDetector(
                    onTap: () => context.goNamed('color-detail', pathParameters: {'color': c.id}),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [c.gradientStart, c.gradientEnd],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: c.color.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(c.emoji, style: const TextStyle(fontSize: 32)),
                          const SizedBox(height: 8),
                          Text(
                            c.name,
                            style: AppTypography.labelBold.copyWith(
                              color: c.id == 'white' ? Colors.black87 : Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
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
          const AdBannerWidget(placementKey: AdPlacements.colorsHub),
          _ColorsBottomNav(),
        ],
      ),
    );
  }
}

class _ColorsTopBar extends StatelessWidget {
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
          IconButton(icon: Icon(Icons.arrow_back, color: AppColors.tertiary, size: 32), onPressed: () => context.goNamed('home'), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
          Flexible(child: Text('Colors World', overflow: TextOverflow.ellipsis, style: AppTypography.headlineLgMobile.copyWith(color: AppColors.tertiary, fontSize: 28))),
          IconButton(icon: Icon(Icons.smart_toy, color: AppColors.tertiary, size: 32), onPressed: () => context.goNamed('robot-lab'), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
        ],
      ),
    );
  }
}

class _ColorsBottomNav extends StatelessWidget {
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
          _ColorsNavItem(icon: Icons.search, label: 'Search', onTap: () => context.goNamed('color-search')),
          _ColorsNavItem(icon: Icons.home, label: 'Hub', isActive: true, onTap: () {}),
          _ColorsNavItem(icon: Icons.quiz, label: 'Quiz', onTap: () => context.goNamed('color-quiz')),
        ],
      ),
    );
  }
}

class _ColorsNavItem extends StatelessWidget {
  final IconData icon; final String label; final bool isActive; final VoidCallback onTap;
  const _ColorsNavItem({required this.icon, required this.label, this.isActive = false, required this.onTap});

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
            Icon(icon, color: AppColors.onSurfaceVariant, size: 28),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.labelBold.copyWith(color: AppColors.onSurfaceVariant, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
