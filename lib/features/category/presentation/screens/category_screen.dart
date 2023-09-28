import 'package:finish_up_app/features/category/presentation/providers/categories_provider.dart';
import 'package:finish_up_app/features/todo/presentation/providers/todo_controller.dart';
import 'package:finish_up_app/features/todo/presentation/widgets/labeled_input_widget.dart';
import 'package:finish_up_app/features/todo/presentation/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../todo/domain/entities/todo.dart';
import '../../domain/entities/category.dart';

final todosFutureProvider =
    FutureProvider.family<List<Todo>, String>((ref, categoryId) async {
  final todoList = await ref.watch(todosListModel).getTodos();
  return todoList.where((todo) => todo.categoryId == categoryId).toList();
});

class CategoryScreen extends ConsumerWidget {
  final String categoryId;
  const CategoryScreen({required this.categoryId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('CategoryScreen: $categoryId');
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Category',
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: LabeledInputWidget(
              label: 'Search tasks',
              inputWidget: TextField(
                decoration: InputDecoration(
                  hintText: 'Search tasks',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ),
          ),
          ref.watch(todosFutureProvider(categoryId)).when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) {
                  return Text('Error: $error');
                },
                data: (todos) {
                  return FutureBuilder<Category>(
                    future: ref
                        .watch(categoryListModel)
                        .getCategoryById(categoryId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final category = snapshot.data!;
                        return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: todos.length,
                          itemBuilder: (_, index) {
                            final todo = todos[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: TodoItemWidget(
                                key: ValueKey(todo.id),
                                isCompleted: todo.isDone,
                                todo: todo,
                                category: category,
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              ),
        ],
      ),
    );
  }
}
