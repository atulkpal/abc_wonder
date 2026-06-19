import 'package:flutter/material.dart';

class PaintSplashHero extends StatelessWidget {
  final String label;
  final Color splashColor;

  const PaintSplashHero({
    super.key,
    required this.label,
    this.splashColor = const Color(0xFF40C4FF),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: splashColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: splashColor.withValues(alpha: 0.25),
                blurRadius: 64,
                spreadRadius: 16,
              ),
            ],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w800,
            color: splashColor,
            shadows: [
              Shadow(
                color: splashColor.withValues(alpha: 0.3),
                blurRadius: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
