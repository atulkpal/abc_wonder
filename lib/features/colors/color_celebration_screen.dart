import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/squishy_button.dart';
import 'package:abc_wonder/core/widgets/animated_float.dart';
import 'package:abc_wonder/core/widgets/sparkle_overlay.dart';

class ColorCelebrationScreen extends StatelessWidget {
  const ColorCelebrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SparkleOverlay(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AnimatedFloat(
                  child: Text('🌈', style: TextStyle(fontSize: 80)),
                ),
                const SizedBox(height: 24),
                Text(
                  'Color Explorer!',
                  style: AppTypography.displayHero.copyWith(
                    color: AppColors.tertiary,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "You've explored all\nthe colors of the world!",
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyXl.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 48),
                SquishyButton(
                  backgroundColor: AppColors.tertiaryContainer,
                  rimColor: const Color(0xFFD9B500),
                  onTap: () => context.goNamed('colors-hub'),
                  child: const Text(
                    'Back to Colors',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF930040)),
                  ),
                ),
                const SizedBox(height: 16),
                SquishyButton(
                  onTap: () => context.goNamed('home'),
                  child: const Text(
                    'Go to Home',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
