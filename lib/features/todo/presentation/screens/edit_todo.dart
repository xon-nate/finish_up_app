import 'package:finish_up_app/features/category/domain/entities/category.dart';
import 'package:finish_up_app/features/todo/presentation/providers/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:finish_up_app/features/todo/presentation/widgets/todo_form.dart'; // Import the TodoForm widget
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../category/presentation/providers/categories_provider.dart';
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
    final todo =
        ref.watch(todosListState).todos.firstWhere((todo) => todo.id == todoId);

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: ref.watch(categoryFutureListProvider).when(
                data: (categories) {
                  return TodoForm(
                    todo: todo,
                    categories: categories,
                    selectedCategory: categories.first,
                    formKey: formKey,
                    taskNameController: taskNameController,
                    descriptionController: descriptionController,
                    dateTimeController: dateTimeController,
                    onCategoryChanged: (category) {
                      selectedCategory = category;
                    },
                    onDateSaved: (date) {
                      dateTimeController.value = date;
                    },
                    onSavePressed: () {
                      if (formKey.currentState!.validate()) {
                        final todo = Todo(
                          id: todoId,
                          title: taskNameController.text,
                          description: descriptionController.text,
                          dueDate: dateTimeController.value,
                          categoryId: selectedCategory!.id,
                          isDone: false,
                        );
                        ref.read(todosListState.notifier).updateTodo(
                              todo,
                            );
                        Navigator.pop(context);
                      }
                    },
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text(error.toString()),
              ),
        ),
      ),
    );
  }
}
