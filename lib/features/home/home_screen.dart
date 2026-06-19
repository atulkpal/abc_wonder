import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/constants/app_constants.dart';
import 'package:abc_wonder/core/widgets/robot_mascot.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _TopAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
                children: [
                  const SizedBox(height: 32),
                  const RobotMascot(),
                  const SizedBox(height: 48),
                  _ModuleGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _TopAppBar extends StatelessWidget {
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
            icon: Icon(Icons.arrow_back,
                color: AppColors.onSurfaceVariant, size: 32),
            onPressed: () => context.goNamed('splash'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              AppConstants.appName,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: AppColors.primary,
                fontSize: 28,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.smart_toy,
                color: AppColors.primary, size: 32),
            onPressed: () => context.goNamed('robot-lab'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _ModuleGrid extends StatelessWidget {
  const _ModuleGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600
            ? 3
            : constraints.maxWidth > 400
                ? 2
                : 1;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 1.4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _ModuleCard(
              label: 'Alphabet\nAdventure',
              color: Color(0xFF40C4FF),
              borderColor: Color(0xFF004E6B),
              icon: Icons.sort_by_alpha,
              iconColor: AppColors.primary,
              progress: 0.75,
              route: 'alphabet-hub',
            ),
            _ModuleCard(
              label: 'Number\nKingdom',
              color: Color(0xFFFDD400),
              borderColor: Color(0xFF6F5C00),
              icon: Icons.onetwothree,
              iconColor: AppColors.secondary,
              progress: 0.5,
              route: 'numbers-hub',
            ),
            _ModuleCard(
              label: 'Colors\nWorld',
              color: Color(0xFFFF9BB2),
              borderColor: Color(0xFF930040),
              icon: Icons.palette,
              iconColor: AppColors.tertiary,
              progress: 0.25,
              route: 'colors-hub',
            ),
            _ModuleCard(
              label: 'Shapes\nFactory',
              color: Color(0xFF7AD0FF),
              borderColor: Color(0xFF004E6B),
              icon: Icons.category,
              iconColor: AppColors.primary,
              progress: 0.83,
              route: 'shapes-hub',
            ),
            _ModuleCard(
              label: 'Days\nPlayground',
              color: Color(0xFFFFE170),
              borderColor: Color(0xFF544600),
              icon: Icons.today,
              iconColor: AppColors.secondary,
              progress: 1.0,
              route: 'days-hub',
            ),
            _ModuleCard(
              label: 'Month\nExplorer',
              color: Color(0xFFFFD9DF),
              borderColor: Color(0xFF3F0018),
              icon: Icons.calendar_month,
              iconColor: AppColors.tertiary,
              progress: 0.33,
              route: 'months-hub',
            ),
          ],
        );
      },
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String label;
  final Color color;
  final Color borderColor;
  final IconData icon;
  final Color iconColor;
  final double progress;
  final String route;

  const _ModuleCard({
    required this.label,
    required this.color,
    required this.borderColor,
    required this.icon,
    required this.iconColor,
    required this.progress,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return RimCard(
      onTap: () => context.goNamed(route),
      backgroundColor: color,
      borderColor: borderColor,
      child: Stack(
        children: [
          Positioned(
            right: -16,
            top: -16,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.1),
                    blurRadius: 24,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: AppTypography.headlineLgMobile.copyWith(
                          color: borderColor,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(icon, color: iconColor, size: 36),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _ProgressBar(
                  value: progress,
                  trackColor: borderColor.withValues(alpha: 0.2),
                  fillColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value;
  final Color trackColor;
  final Color fillColor;

  const _ProgressBar({
    required this.value,
    required this.trackColor,
    required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: trackColor.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            FractionallySizedBox(
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: fillColor,
                  border: Border(
                    right: BorderSide(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white38, Colors.transparent],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

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
          _NavItem(
            icon: Icons.videogame_asset,
            label: 'Play',
            isActive: false,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.school,
            label: 'Learn',
            isActive: true,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.manage_accounts,
            label: 'Parents',
            isActive: false,
            onTap: () => context.goNamed('parent-dashboard'),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
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
