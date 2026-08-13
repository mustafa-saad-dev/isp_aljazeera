import 'package:flutter/material.dart';

class DecorativeDot extends StatelessWidget {
  const DecorativeDot({
    super.key,
    this.color = Colors.blue,
    this.opacity = 0.3,
    this.size = 5,
  });

  final Color color;
  final double opacity;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}
