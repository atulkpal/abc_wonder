import 'package:flutter/material.dart';

class ToyShadow extends StatelessWidget {
  final Widget child;

  const ToyShadow({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 102, 138, 0.15),
            blurRadius: 40,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
