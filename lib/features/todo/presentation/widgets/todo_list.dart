import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/domain/entities/category.dart';
import '../../../category/presentation/providers/categories_provider.dart';
import '../../domain/entities/todo.dart';
import '../providers/todo_controller.dart';
import 'todo_item.dart';
import 'todo_item_shimmer.dart';

final futureCategoryProvider =
    FutureProvider.family<Category, String>((ref, id) async {
  final category = await ref.watch(categoryListModel).getCategoryById(id);
  debugPrint(category.name);
  return category;
});

class TodoList extends ConsumerWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return FutureBuilder(
      future: Future.wait([
        ref.read(categoryListModel).getCategories(),
        ref
            .read(todosListState.notifier)
            .getTodos(), // Assuming a getTodos method exists
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Category> categories = snapshot.data![0];
          final List<Todo> todos = snapshot.data![1];

          // Create a map of categoryId to Category object
          final categoryMap = {
            for (var category in categories) category.id: category
          };

          return ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (_, index) {
              final todo = todos[index];
              final categoryId = todo.categoryId;

              // Retrieve the corresponding category from the map
              final category = categoryMap[categoryId];

              if (category != null) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TodoItemWidget(
                    key: ValueKey(todo.id),
                    todo: todo,
                    category: category,
                  ),
                );
              } else {
                //assign a default category the first category in the list
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TodoItemShimmer(),
                );
              }
            },
          );
        }
      },
    );
  }
}
