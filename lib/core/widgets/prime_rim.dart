import 'package:flutter/material.dart';

class RimDecoration extends StatelessWidget {
  final Widget child;
  final Color rimColor;
  final double rimWidth;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const RimDecoration({
    super.key,
    required this.child,
    this.rimColor = const Color(0xFF004C69),
    this.rimWidth = 6,
    this.backgroundColor = const Color(0xFF40C4FF),
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: rimColor,
            blurRadius: 0,
            offset: Offset(0, rimWidth),
          ),
        ],
      ),
      child: child,
    );
  }
}
