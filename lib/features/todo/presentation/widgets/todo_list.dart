import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/domain/entities/category.dart';
import '../../../category/presentation/providers/categories_provider.dart';
import '../providers/todo_controller.dart';
import 'todo_item.dart';
import 'todo_item_shimmer.dart';

final futureCategoryProvider =
    FutureProvider.family<Category, String>((ref, id) async {
  final category = await ref.watch(categoryListModel).getCategoryById(id);
  return category;
});

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final todos = ref.watch(todosListState).todos;

        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (_, index) {
            final todo = todos[index];
            return ref.watch(futureCategoryProvider(todo.categoryId)).when(
                  loading: () => const TodoItemShimmer(),
                  error: (error, stackTrace) {
                    return Text('Error: $error');
                  },
                  data: (category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TodoItemWidget(
                        key: ValueKey(todo.id),
                        todo: todo,
                        category: category,
                      ),
                    );
                  },
                );
          },
        );
      },
    );
  }
}
