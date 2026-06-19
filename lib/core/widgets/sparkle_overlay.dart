import 'dart:math';
import 'package:flutter/material.dart';

class SparkleOverlay extends StatefulWidget {
  final Widget child;
  final double opacity;

  const SparkleOverlay({
    super.key,
    required this.child,
    this.opacity = 0.15,
  });

  @override
  State<SparkleOverlay> createState() => _SparkleOverlayState();
}

class _SparkleOverlayState extends State<SparkleOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _SparklePainter(
                    progress: _controller.value,
                    opacity: widget.opacity,
                  ),
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklePainter extends CustomPainter {
  final double progress;
  final double opacity;

  _SparklePainter({required this.progress, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: opacity);

    final random = Random(42);
    const spacing = 150.0;
    final offset = (progress * spacing * 2) % spacing;

    for (double x = -spacing; x < size.width + spacing; x += spacing) {
      for (double y = -spacing; y < size.height + spacing; y += spacing) {
        final dx = x + offset + random.nextDouble() * 10;
        final dy = y + random.nextDouble() * 10;
        canvas.drawCircle(
          Offset(dx % (size.width + spacing) - spacing / 2,
              dy % (size.height + spacing) - spacing / 2),
          3,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_SparklePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
