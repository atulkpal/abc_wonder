import 'package:flutter/material.dart';

class BeadProgress extends StatelessWidget {
  final int total;
  final int current;
  final Color activeColor;
  final Color inactiveColor;
  final double beadSize;
  final double spacing;

  const BeadProgress({
    super.key,
    required this.total,
    required this.current,
    this.activeColor = const Color(0xFF40C4FF),
    this.inactiveColor = const Color(0xFFDEE3E8),
    this.beadSize = 24,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      clipBehavior: Clip.hardEdge,
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(total, (index) {
          final isActive = index <= current;
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0 : spacing),
            child: Container(
            width: beadSize,
            height: beadSize,
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? const Color(0xFF00668A)
                      : Colors.black.withValues(alpha: 0.1),
                  blurRadius: 0,
                  offset: const Offset(0, -3),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        );
      }),
    ),
    );
  }
}
