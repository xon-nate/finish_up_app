import 'package:flutter/material.dart';

class LabeledInputWidget extends StatelessWidget {
  final String label;
  final Widget inputWidget;
  const LabeledInputWidget({
    super.key,
    required this.label,
    required this.inputWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        inputWidget,
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
