import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  final bool isCompleted;
  const TodoItemWidget({
    required this.isCompleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color:
              isCompleted ? const Color(0xFF006ED4) : const Color(0xFF111111),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          tileColor: Colors.transparent,
          trailing: Icon(
            isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
            size: 35,
            color:
                isCompleted ? const Color(0xFF006ed4) : const Color(0xFF7B8088),
          ),
          title: Text(
            'Finish up the design',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isCompleted
                  ? const Color(0xFF006ed4)
                  : const Color(0xFF111111),
              decoration: isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              decorationColor: const Color(0xFF006ed4),
            ),
          ),
          subtitle: Text(
            'Finish up the design for the project',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: isCompleted
                  ? const Color(0xFF006ed4)
                  : const Color(0xFF7B8088),
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
