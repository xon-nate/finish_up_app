import 'package:finish_up_app/core/utils/category_colors.dart';
import 'package:flutter/material.dart';

class TaskCategoryWidget extends StatelessWidget {
  const TaskCategoryWidget({
    super.key,
    required this.categoryColorPair,
    required this.categoryName,
    required this.categoryIcon,
  });

  final ColorPair categoryColorPair;
  final String categoryName;
  final IconData categoryIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: categoryColorPair.color,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 0),
            // blurStyle: BlurStyle.inner,
            color: Colors.black12,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: categoryColorPair.darkColor,
          width: 1.6,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            categoryIcon,
            size: 25,
            color: categoryColorPair.darkColor,
          ),
          const SizedBox(width: 5),
          Text(
            categoryName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
