import 'package:flutter/material.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/pressable_3d.dart';
import 'package:abc_wonder/core/widgets/squishy_button.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/core/widgets/tactile_card.dart';
import 'package:abc_wonder/core/widgets/bead_progress.dart';
import 'package:abc_wonder/core/widgets/animated_float.dart';
import 'package:abc_wonder/core/widgets/shimmer_loading.dart';
import 'package:abc_wonder/core/widgets/inner_glow_top.dart';
import 'package:abc_wonder/core/widgets/toy_shadow.dart';
import 'package:abc_wonder/core/widgets/prime_rim.dart';
import 'package:abc_wonder/core/widgets/pulse_ring.dart';
import 'package:abc_wonder/core/widgets/wiggle_animation.dart';
import 'package:abc_wonder/core/widgets/sparkle_overlay.dart';
import 'package:abc_wonder/core/gradients/metallic_gradient.dart';
import 'package:abc_wonder/core/gradients/gem_gradient.dart';
import 'package:abc_wonder/core/gradients/seasonal_gradient.dart';
import 'package:abc_wonder/core/gradients/paint_splash_hero.dart';

class StyleGuideScreen extends StatelessWidget {
  const StyleGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Design System — Style Guide'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle('Colors'),
            _ColorGrid(),
            SizedBox(height: 32),
            _SectionTitle('Typography'),
            _TypographyDemo(),
            SizedBox(height: 32),
            _SectionTitle('Pressable3D'),
            _Pressable3DDemo(),
            SizedBox(height: 32),
            _SectionTitle('SquishyButton'),
            _SquishyButtonDemo(),
            SizedBox(height: 32),
            _SectionTitle('RimCard'),
            _RimCardDemo(),
            SizedBox(height: 32),
            _SectionTitle('TactileCard'),
            _TactileCardDemo(),
            SizedBox(height: 32),
            _SectionTitle('BeadProgress'),
            _BeadProgressDemo(),
            SizedBox(height: 32),
            _SectionTitle('AnimatedFloat'),
            _AnimatedFloatDemo(),
            SizedBox(height: 32),
            _SectionTitle('ShimmerLoading'),
            _ShimmerLoadingDemo(),
            SizedBox(height: 32),
            _SectionTitle('InnerGlowTop + ToyShadow + RimDecoration'),
            _ShadowDemos(),
            SizedBox(height: 32),
            _SectionTitle('PulseRing'),
            _PulseRingDemo(),
            SizedBox(height: 32),
            _SectionTitle('WiggleAnimation'),
            _WiggleDemo(),
            SizedBox(height: 32),
            _SectionTitle('SparkleOverlay'),
            _SparkleDemo(),
            SizedBox(height: 32),
            _SectionTitle('MetallicGradient'),
            _MetallicDemo(),
            SizedBox(height: 32),
            _SectionTitle('GemGradient'),
            _GemDemo(),
            SizedBox(height: 32),
            _SectionTitle('SeasonalGradient'),
            _SeasonalDemo(),
            SizedBox(height: 32),
            _SectionTitle('PaintSplashHero'),
            _PaintSplashDemo(),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: AppTypography.headlineLgMobile.copyWith(
          color: AppColors.onSurface,
          fontSize: 24,
        ),
      ),
    );
  }
}

class _ColorGrid extends StatelessWidget {
  const _ColorGrid();

  @override
  Widget build(BuildContext context) {
    final colors = {
      'surface': AppColors.surface,
      'primary': AppColors.primary,
      'primary-container': AppColors.primaryContainer,
      'secondary': AppColors.secondary,
      'secondary-container': AppColors.secondaryContainer,
      'tertiary': AppColors.tertiary,
      'tertiary-container': AppColors.tertiaryContainer,
      'on-surface': AppColors.onSurface,
      'on-surface-variant': AppColors.onSurfaceVariant,
      'outline': AppColors.outline,
      'error': AppColors.error,
      'surface-dim': AppColors.surfaceDim,
      'surface-container': AppColors.surfaceContainer,
      'primary-fixed': AppColors.primaryFixed,
      'primary-fixed-dim': AppColors.primaryFixedDim,
    };

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: colors.entries.map((e) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: e.value,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.outlineVariant),
              ),
            ),
            const SizedBox(height: 4),
            Text(e.key, style: const TextStyle(fontSize: 10)),
          ],
        );
      }).toList(),
    );
  }
}

class _TypographyDemo extends StatelessWidget {
  const _TypographyDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Display Hero (48px, 800)', style: AppTypography.displayHero),
        const SizedBox(height: 8),
        Text('Headline LG (32px, 700)', style: AppTypography.headlineLg),
        const SizedBox(height: 8),
        Text('Headline LG Mobile (28px, 700)',
            style: AppTypography.headlineLgMobile),
        const SizedBox(height: 8),
        Text('Body XL (24px, 600)', style: AppTypography.bodyXl),
        const SizedBox(height: 8),
        Text('Label Bold (18px, 700)', style: AppTypography.labelBold),
      ],
    );
  }
}

class _Pressable3DDemo extends StatelessWidget {
  const _Pressable3DDemo();

  @override
  Widget build(BuildContext context) {
    return Pressable3D(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00668A).withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Text('Tap me!', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class _SquishyButtonDemo extends StatelessWidget {
  const _SquishyButtonDemo();

  @override
  Widget build(BuildContext context) {
    return SquishyButton(
      onTap: () {},
      child: const Text(
        'Squishy Button',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _RimCardDemo extends StatelessWidget {
  const _RimCardDemo();

  @override
  Widget build(BuildContext context) {
    return RimCard(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Rim Card — tap to squish',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _TactileCardDemo extends StatelessWidget {
  const _TactileCardDemo();

  @override
  Widget build(BuildContext context) {
    return TactileCard(
      child: const Text(
        'Tactile Card',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _BeadProgressDemo extends StatelessWidget {
  const _BeadProgressDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BeadProgress(total: 5, current: 2),
        const SizedBox(height: 12),
        BeadProgress(total: 26, current: 13),
      ],
    );
  }
}

class _AnimatedFloatDemo extends StatelessWidget {
  const _AnimatedFloatDemo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnimatedFloat(
          variant: FloatVariant.fast,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: Text('1')),
          ),
        ),
        AnimatedFloat(
          variant: FloatVariant.normal,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: Text('2')),
          ),
        ),
        AnimatedFloat(
          variant: FloatVariant.slow,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.tertiaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: Text('3')),
          ),
        ),
      ],
    );
  }
}

class _ShimmerLoadingDemo extends StatelessWidget {
  const _ShimmerLoadingDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ShimmerLoading(width: double.infinity, height: 80),
        SizedBox(height: 12),
        ShimmerLoading(width: 200, height: 40, borderRadius: 8),
      ],
    );
  }
}

class _ShadowDemos extends StatelessWidget {
  const _ShadowDemos();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InnerGlowTop(
          child: Container(
            width: 120,
            height: 60,
            color: AppColors.surfaceContainer,
            child: const Center(child: Text('InnerGlowTop')),
          ),
        ),
        const SizedBox(height: 12),
        ToyShadow(
          child: Container(
            width: 120,
            height: 60,
            color: Colors.white,
            child: const Center(child: Text('ToyShadow')),
          ),
        ),
        const SizedBox(height: 12),
        RimDecoration(
          child: const Text('RimDecoration', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class _PulseRingDemo extends StatelessWidget {
  const _PulseRingDemo();

  @override
  Widget build(BuildContext context) {
    return PulseRing(
      onTap: () {},
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Icon(Icons.touch_app, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}

class _WiggleDemo extends StatelessWidget {
  const _WiggleDemo();

  @override
  Widget build(BuildContext context) {
    return WiggleAnimation(
      onTap: () {},
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.tertiaryContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Center(
          child: Text('🍎', style: TextStyle(fontSize: 40)),
        ),
      ),
    );
  }
}

class _SparkleDemo extends StatelessWidget {
  const _SparkleDemo();

  @override
  Widget build(BuildContext context) {
    return SparkleOverlay(
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Text(
            'Sparkle Overlay',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _MetallicDemo extends StatelessWidget {
  const _MetallicDemo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: MetallicGradient.decoration(
            variant: MetallicVariant.gold,
            borderRadius: 16,
          ),
          child: const Center(child: Text('Gold', style: TextStyle(fontWeight: FontWeight.bold))),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: MetallicGradient.decoration(
            variant: MetallicVariant.silver,
            borderRadius: 16,
          ),
          child: const Center(child: Text('Silver', style: TextStyle(fontWeight: FontWeight.bold))),
        ),
      ],
    );
  }
}

class _GemDemo extends StatelessWidget {
  const _GemDemo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _GemSquare(GemVariant.ruby, 'Ruby'),
        _GemSquare(GemVariant.sapphire, 'Sapphire'),
        _GemSquare(GemVariant.emerald, 'Emerald'),
        _GemSquare(GemVariant.amethyst, 'Amethyst'),
      ],
    );
  }
}

class _GemSquare extends StatelessWidget {
  final GemVariant variant;
  final String label;
  const _GemSquare(this.variant, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: GemGradient.decoration(variant: variant, borderRadius: 16),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

class _SeasonalDemo extends StatelessWidget {
  const _SeasonalDemo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SeasonalSquare(Season.winter, 'Winter'),
        _SeasonalSquare(Season.spring, 'Spring'),
        _SeasonalSquare(Season.summer, 'Summer'),
        _SeasonalSquare(Season.autumn, 'Autumn'),
      ],
    );
  }
}

class _SeasonalSquare extends StatelessWidget {
  final Season season;
  final String label;
  const _SeasonalSquare(this.season, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: SeasonalGradient.decoration(season: season, borderRadius: 16),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

class _PaintSplashDemo extends StatelessWidget {
  const _PaintSplashDemo();

  @override
  Widget build(BuildContext context) {
    return const PaintSplashHero(label: 'Red', splashColor: Color(0xFFFF6B6B));
  }
}
