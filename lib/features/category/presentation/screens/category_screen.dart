import 'package:finish_up_app/features/category/presentation/providers/categories_provider.dart';
import 'package:finish_up_app/features/todo/presentation/providers/todo_controller.dart';
import 'package:finish_up_app/features/todo/presentation/widgets/labeled_input_widget.dart';
import 'package:finish_up_app/features/todo/presentation/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../todo/domain/entities/todo.dart';
import '../../domain/entities/category.dart';

final todosFutureProvider = FutureProvider.autoDispose
    .family<List<Todo>, String>((ref, categoryId) async {
  final todoList = await ref.watch(todosListModel).getTodos();
  return todoList.where((todo) => todo.categoryId == categoryId).toList();
});

final categoryByIdFutureProvider =
    FutureProvider.autoDispose.family<Category, String>(
  (ref, categoryId) async {
    final category =
        await ref.watch(categoryListModel).getCategoryById(categoryId);
    return category;
  },
);
final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

class CategoryScreen extends ConsumerWidget {
  final String categoryId;
  const CategoryScreen({required this.categoryId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Category',
        ),
      ),
      body: Column(
        children: [
          const SearchBar(),
          Expanded(
            child: TodoListWidget(
              categoryId: categoryId,
              searchQuery: searchQuery,
            ),
          )
        ],
      ),
    );
  }
}

class TodoListWidget extends ConsumerWidget {
  final String categoryId;
  final String searchQuery;

  const TodoListWidget(
      {super.key, required this.categoryId, required this.searchQuery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(todosFutureProvider(categoryId)).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) {
            return Text('Error: $error');
          },
          data: (todos) {
            final filteredTodos = todos.where((todo) {
              return todo.title.toLowerCase().contains(searchQuery);
            }).toList();

            if (filteredTodos.isEmpty) {
              return const Center(
                child: Text('No Tasks Found'),
              );
            }

            return ref.watch(categoryByIdFutureProvider(categoryId)).when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) {
                    return Text('Error: $error');
                  },
                  data: (category) {
                    return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredTodos.length,
                      itemBuilder: (_, index) {
                        final todo = filteredTodos[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: TodoItemWidget(
                            key: ValueKey(todo.id),
                            category: category,
                            todo: todo,
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

class SearchBar extends ConsumerWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: LabeledInputWidget(
        label: 'Search tasks',
        inputWidget: TextField(
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).update((state) => value);
          },
          decoration: InputDecoration(
            fillColor: const Color(0xFFECECEC),
            hintText: 'Search tasks',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
