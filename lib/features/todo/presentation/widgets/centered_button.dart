import 'package:flutter/material.dart';

class CenteredCallToActionButton extends StatelessWidget {
  final Function() onPressed;
  const CenteredCallToActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: const Color(0xFF2C2C2C),
      ),
      child: const Text(
        'Add Task',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
