import 'package:flutter/material.dart';

class Pressable3D extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double translateY;
  final Duration duration;

  const Pressable3D({
    super.key,
    required this.child,
    this.onTap,
    this.translateY = 4,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<Pressable3D> createState() => _Pressable3DState();
}

class _Pressable3DState extends State<Pressable3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: widget.translateY)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: const Cubic(0.175, 0.885, 0.32, 1.275),
      reverseCurve: const Cubic(0.175, 0.885, 0.32, 1.275),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap?.call();
  }
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}
