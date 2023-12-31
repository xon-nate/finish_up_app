import 'package:finish_up_app/features/category/domain/entities/category.dart';
import 'package:finish_up_app/features/todo/presentation/providers/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:finish_up_app/features/todo/presentation/widgets/todo_form.dart'; // Import the TodoForm widget
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../category/presentation/providers/categories_provider.dart';
import '../../../category/presentation/screens/category_screen.dart';
import '../../domain/entities/todo.dart';
import '../controllers/date_time_controller.dart';

class EditTodoScreen extends ConsumerWidget {
  final String todoId;
  EditTodoScreen({Key? key, required this.todoId}) : super(key: key);
  final DateTimeController dateTimeController = DateTimeController();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    Category? selectedCategory;
    if (!context.mounted) {
      return const Scaffold(
        body: Center(
          child: Text('Widget is not active'),
        ),
      );
    }

    final todosState = ref.watch(todosListState);

    // Check if todosState is null or empty
    if (todosState.todos.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Todos data is not available'),
        ),
      );
    }

    // Find the specific todo with the given todoId
    final todo = todosState.todos.firstWhere((todo) => todo.id == todoId);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Todo',
          style: TextStyle(
            color: Color(0xFF111111),
          ),
        ),
        backgroundColor: const Color(0xFFECECEC),
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Delete Todo'),
                    content: const Text('Are you sure you want to delete?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          ref.read(todosListState.notifier).deleteTodo(todoId);
                          context.go('/');
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: ref.watch(categoryFutureListProvider).when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text(error.toString()),
                data: (categories) {
                  return TodoForm(
                    todo: todo,
                    categories: categories,
                    selectedCategory: categories.first,
                    formKey: formKey,
                    taskNameController: taskNameController,
                    descriptionController: descriptionController,
                    dateTimeController: dateTimeController,
                    onCategoryChanged: (category) =>
                        selectedCategory = category,
                    onDateSaved: (date) => dateTimeController.value = date,
                    onSavePressed: () {
                      if (formKey.currentState!.validate()) {
                        final newTodo = Todo(
                          id: todoId,
                          title: taskNameController.text,
                          description: descriptionController.text,
                          dueDate: dateTimeController.value,
                          categoryId: selectedCategory?.id ?? todo.categoryId,
                          isDone: false,
                        );
                        ref.read(todosListState.notifier).updateTodo(newTodo);

                        Navigator.pop(context);
                      }
                    },
                  );
                },
              ),
        ),
      ),
    );
  }
}
