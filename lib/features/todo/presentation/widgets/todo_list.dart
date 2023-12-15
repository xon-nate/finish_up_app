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
  debugPrint(category.name);
  return category;
});

class TodoList extends ConsumerWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return FutureBuilder(
      future: ref.watch(categoryListModel).getCategories(),
      builder: (context, AsyncSnapshot<List<Category>> categorySnapshot) {
        if (categorySnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (categorySnapshot.hasError) {
          return Center(child: Text('Error: ${categorySnapshot.error}'));
        } else if (!categorySnapshot.hasData ||
            categorySnapshot.data!.isEmpty) {
          return const Center(child: Text('No categories available'));
        } else {
          final List<Category> categories = categorySnapshot.data!;
          final categoryMap = {
            for (var category in categories) category.id: category
          };

          return Consumer(
            builder: (context, ref, child) {
              final todos = ref.watch(todosListState).todos;

              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: todos.length,
                itemBuilder: (_, index) {
                  final todo = todos[index];
                  final categoryId = todo.categoryId;
                  final category = categoryMap[categoryId];

                  if (category != null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TodoItemWidget(
                        key: ValueKey(todo.id),
                        todo: todo,
                        category: category,
                      ),
                    );
                  } else {
                    // Assign a default category or handle this case differently
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TodoItemShimmer(),
                    );
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}

// class TodoList extends ConsumerWidget {
//   const TodoList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ref) {
//     return FutureBuilder(
//       future: Future.wait([
//         ref.watch(categoryListModel).getCategories(),
//         ref.watch(todosListState.notifier).getTodos(),
//       ]),
//       builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData ||
//             snapshot.data![0] == null ||
//             snapshot.data![1] == null) {
//           return const Center(child: Text('No data available'));
//         } else {
//           final List<Category> categories = snapshot.data![0];
//           final List<Todo> todos = snapshot.data![1];

//           final categoryMap = {
//             for (var category in categories) category.id: category
//           };

//           return ListView.builder(
//             physics: const ClampingScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: todos.length,
//             itemBuilder: (_, index) {
//               final todo = todos[index];
//               final categoryId = todo.categoryId;
//               final category = categoryMap[categoryId];

//               if (category != null) {
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: TodoItemWidget(
//                     key: ValueKey(todo.id),
//                     todo: todo,
//                     category: category,
//                   ),
//                 );
//               } else {
//                 // Assign a default category or handle this case differently
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: TodoItemShimmer(),
//                 );
//               }
//             },
//           );
//         }
//       },
//     );
//   }
// }