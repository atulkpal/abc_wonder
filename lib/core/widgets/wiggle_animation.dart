import 'package:flutter/material.dart';

class WiggleAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const WiggleAnimation({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  State<WiggleAnimation> createState() => _WiggleAnimationState();
}

class _WiggleAnimationState extends State<WiggleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rotationAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -0.087), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.087, end: 0.087), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.087, end: 0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1, end: 1.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.1), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward(from: 0);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
