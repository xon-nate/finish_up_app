import 'package:flutter/material.dart';

class AnimatedTextDecoration extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final FontWeight fontWeight;
  final double fontSize;

  const AnimatedTextDecoration({
    super.key,
    required this.text,
    required this.isCompleted,
    required this.fontWeight,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'Kumbh',
        color: isCompleted ? const Color(0xFF006ed4) : const Color(0xFF111111),
        decoration:
            isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        decorationColor: const Color(0xFF006ed4),
        decorationThickness: isCompleted ? 2.0 : 0.0,
      ),
      duration: const Duration(milliseconds: 300),
      child: Text(text),
    );
  }
}
