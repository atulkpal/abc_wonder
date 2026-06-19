import 'package:flutter/material.dart';

enum FloatVariant { fast, normal, slow }

class AnimatedFloat extends StatefulWidget {
  final Widget child;
  final FloatVariant variant;
  final double amplitude;

  const AnimatedFloat({
    super.key,
    required this.child,
    this.variant = FloatVariant.normal,
    this.amplitude = 15,
  });

  @override
  State<AnimatedFloat> createState() => _AnimatedFloatState();
}

class _AnimatedFloatState extends State<AnimatedFloat>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late Animation<double> _rotateAnimation;

  Duration get _duration {
    switch (widget.variant) {
      case FloatVariant.fast:
        return const Duration(seconds: 3);
      case FloatVariant.normal:
        return const Duration(seconds: 4);
      case FloatVariant.slow:
        return const Duration(seconds: 5);
    }
  }

  Duration get _delay {
    switch (widget.variant) {
      case FloatVariant.fast:
        return Duration.zero;
      case FloatVariant.normal:
        return const Duration(milliseconds: 500);
      case FloatVariant.slow:
        return const Duration(seconds: 1);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: -widget.amplitude).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _rotateAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
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
    Future.delayed(_delay, () {
      if (mounted) _controller.repeat(reverse: true);
    });

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.rotate(
          angle: _rotateAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
