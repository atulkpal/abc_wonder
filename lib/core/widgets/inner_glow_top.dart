import 'package:flutter/material.dart';

class InnerGlowTop extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double blurRadius;
  final double offset;

  const InnerGlowTop({
    super.key,
    required this.child,
    this.opacity = 0.4,
    this.blurRadius = 6,
    this.offset = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: opacity),
            blurRadius: blurRadius,
            offset: Offset(0, offset),
          ),
        ],
      ),
      child: child,
    );
  }
}
