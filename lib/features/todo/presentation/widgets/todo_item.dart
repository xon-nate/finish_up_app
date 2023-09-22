import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../category/domain/entities/category.dart';
import '../../../category/presentation/providers/categories_provider.dart';
import '../../domain/entities/todo.dart';
import './todo_category.dart';
import '../state/item_state.dart';
import 'animated_text_deco.dart';

class TodoItemWidget extends ConsumerStatefulWidget {
  final bool isCompleted;
  final Todo todo;
  final Category category;
  const TodoItemWidget({
    required this.isCompleted,
    required this.todo,
    required this.category,
    super.key,
  });

  @override
  ConsumerState<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends ConsumerState<TodoItemWidget> {
  late final StateNotifierProvider<ItemState, bool> isCompletedProvider;

  @override
  void initState() {
    super.initState();
    isCompletedProvider = StateNotifierProvider<ItemState, bool>(
      (ref) => ItemState(widget.isCompleted),
    );
    //print all params
    // debugPrint('isCompleted: ${widget.isCompleted}');
    // debugPrint('todo: ${widget.todo}');
    // debugPrint('category: ${widget.category}');
  }

  @override
  Widget build(BuildContext context) {
    final isCompletedValue = ref.watch(isCompletedProvider);
    // debugPrint('category id: ${widget.category.id}');
    // debugPrint('category name: ${widget.category.name}');
    // debugPrint('category icon: ${widget.category.icon}');
    // debugPrint('category color: ${widget.category.categoryColor}');

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: isCompletedValue
                    ? const Color(0xFF006ED4).withOpacity(0.2)
                    : const Color(0xFF111111).withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color: isCompletedValue
                  ? const Color(0xFF006ED4)
                  : const Color(0xFF111111),
              width: 2,
            ),
            color: isCompletedValue
                ? const Color(0xFFD6EBFF)
                : const Color(0xFFFFFFFF),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                //navigate to edit todo screen using this
                // GoRoute(
                // path: '/edit/:todoId',
                // builder: (context, state) => EditTodoScreen(
                // todoId: state.pathParameters['todoId']!,
                // ),
                // ),
                context.push('/edit/${widget.todo.id}');
              },
              tileColor: Colors.transparent,
              trailing: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            isCompletedValue
                                ? 'Mark as not completed?'
                                : 'Mark as completed?',
                          ),
                          // surfaceTintColor: const Color(0xFF006ed4),
                          icon: const Icon(
                            Icons.info,
                            size: 30,
                          ),
                          iconColor: const Color(0xFF006ed4),
                          semanticLabel: isCompletedValue
                              ? 'Mark as not completed?'
                              : 'Mark as completed?',
                          content: Text(
                            isCompletedValue
                                ? 'Are you sure you want to mark this task as not completed (pending)?'
                                : 'Are you sure you want to mark this task as completed?',
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment: MainAxisAlignment.spaceBetween,

                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ref
                                          .read(isCompletedProvider.notifier)
                                          .toggle();
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color(0xFF2C2C2C),
                                      ),
                                    ),
                                    child: const Text(
                                      'Confirm',
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  key: UniqueKey(),
                  icon: Icon(
                    key: UniqueKey(),
                    isCompletedValue
                        ? Icons.check_box
                        : Icons.check_box_outline_blank_outlined,
                    size: 30,
                    color: isCompletedValue
                        ? const Color(0xFF006ed4)
                        : const Color(0xFF7B8088),
                  ),
                ),
              ),
              title: AnimatedTextDecoration(
                text: widget.todo.title,
                isCompleted: isCompletedValue,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              subtitle: AnimatedTextDecoration(
                text: widget.todo.description,
                isCompleted: isCompletedValue,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          right: MediaQuery.of(context).size.width * 0.05,
          // use todo to get category
          child: TaskCategoryWidget(
            categoryColorPair: widget.category.categoryColor,
            categoryIcon: widget.category.icon,
            categoryName: widget.category.name,
          ),
        ),
      ],
    );
  }
}
