import 'package:flutter/material.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/toy_shadow.dart';
import 'package:abc_wonder/core/widgets/inner_glow_top.dart';

class RobotMascot extends StatefulWidget {
  final double size;
  final String speechText;

  const RobotMascot({
    super.key,
    this.size = 192,
    this.speechText = 'What would you like to learn today?',
  });

  @override
  State<RobotMascot> createState() => _RobotMascotState();
}

class _RobotMascotState extends State<RobotMascot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _bounceAnimation = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return RepaintBoundary(
      child: Flex(
      direction: isTablet ? Axis.horizontal : Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _bounceAnimation,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, _bounceAnimation.value),
            child: child,
          ),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text('🤖', style: TextStyle(fontSize: widget.size * 0.5)),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: isTablet ? -16 : 0,
              top: isTablet ? 0 : 16,
            ),
            child: ToyShadow(
              child: InnerGlowTop(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.surfaceContainerHighest,
                        width: 4,
                      ),
                    ),
                  ),
                  child: Text(
                    widget.speechText,
                    style: AppTypography.headlineLgMobile.copyWith(
                      color: AppColors.onPrimaryFixedVariant,
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }
}
