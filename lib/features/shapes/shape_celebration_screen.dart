import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/squishy_button.dart';
import 'package:abc_wonder/core/widgets/animated_float.dart';
import 'package:abc_wonder/core/widgets/sparkle_overlay.dart';

class ShapeCelebrationScreen extends StatelessWidget {
  const ShapeCelebrationScreen({super.key});

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
                const AnimatedFloat(child: Text('⭐', style: TextStyle(fontSize: 80))),
                const SizedBox(height: 24),
                Text('Shape Master!', style: AppTypography.displayHero.copyWith(color: const Color(0xFF00668A), fontSize: 40)),
                const SizedBox(height: 16),
                Text("You've mastered all\nthe shapes!", textAlign: TextAlign.center,
                  style: AppTypography.bodyXl.copyWith(color: AppColors.onSurfaceVariant)),
                const SizedBox(height: 48),
                SquishyButton(
                  backgroundColor: const Color(0xFF7AD0FF),
                  rimColor: const Color(0xFF004E6B),
                  onTap: () => context.goNamed('shapes-hub'),
                  child: const Text('Back to Shapes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001E2C))),
                ),
                const SizedBox(height: 16),
                SquishyButton(
                  onTap: () => context.goNamed('home'),
                  child: const Text('Go to Home',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
