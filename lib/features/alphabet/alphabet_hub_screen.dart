import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/static/alphabet_data.dart';
import 'package:abc_wonder/data/models/letter_model.dart';
import 'package:abc_wonder/core/monetization/ad_banner_widget.dart';
import 'package:abc_wonder/core/monetization/monetization_service.dart';

class AlphabetHubScreen extends StatelessWidget {
  const AlphabetHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _AlphabetTopBar(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 6 : 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: AlphabetData.items.length,
                itemBuilder: (context, index) {
                  final letter = AlphabetData.items[index];
                  return _LetterCard(letter: letter);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AdBannerWidget(placementKey: AdPlacements.alphabetHub),
          const _AlphabetBottomNav(),
        ],
      ),
    );
  }
}

class _AlphabetTopBar extends StatelessWidget {
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
            icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 32),
            onPressed: () => context.goNamed('home'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Alphabet Adventure',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: AppColors.primary,
                fontSize: 28,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.smart_toy, color: AppColors.primary, size: 32),
            onPressed: () => context.goNamed('robot-lab'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _LetterCard extends StatelessWidget {
  final LetterModel letter;
  const _LetterCard({required this.letter});

  @override
  Widget build(BuildContext context) {
    return RimCard(
      onTap: () => context.goNamed('alphabet-detail', pathParameters: {'letter': letter.id}),
      backgroundColor: AppColors.primaryContainer,
      borderColor: const Color(0xFF004E6B),
      child: Center(
        child: Text(
          letter.character,
          style: AppTypography.displayHero.copyWith(
            color: AppColors.onPrimaryContainer,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}

class _AlphabetBottomNav extends StatelessWidget {
  const _AlphabetBottomNav();

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
          _AlphabetNavItem(
            icon: Icons.auto_awesome_motion,
            label: 'Review',
            onTap: () => context.goNamed('alphabet-review'),
          ),
          _AlphabetNavItem(
            icon: Icons.home,
            label: 'Hub',
            isActive: true,
            onTap: () {},
          ),
          _AlphabetNavItem(
            icon: Icons.celebration,
            label: 'Celebrate',
            onTap: () => context.goNamed('alphabet-celebration'),
          ),
        ],
      ),
    );
  }
}

class _AlphabetNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _AlphabetNavItem({
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
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF004C69),
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
                Icon(icon, color: AppColors.onPrimaryContainer, size: 28),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: AppTypography.labelBold.copyWith(
                    color: AppColors.onPrimaryContainer,
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
