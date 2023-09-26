import 'package:finish_up_app/features/category/domain/entities/category.dart';
import 'package:finish_up_app/features/todo/presentation/providers/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:finish_up_app/features/todo/presentation/widgets/todo_form.dart'; // Import the TodoForm widget
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../category/presentation/providers/categories_provider.dart';
import '../../domain/entities/todo.dart';
import '../controllers/date_time_controller.dart';

class EditTodoScreen extends ConsumerStatefulWidget {
  final String todoId;
  const EditTodoScreen({
    required this.todoId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends ConsumerState<EditTodoScreen> {
  final DateTimeController dateTimeController = DateTimeController();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Category? selectedCategory;

  Todo getTodo(String id) {
    final todo =
        ref.watch(todosListState).todos.firstWhere((todo) => todo.id == id);
    return todo;
  }

  @override
  Widget build(BuildContext context) {
    final todo = getTodo(widget.todoId);

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
              child: FutureBuilder<List<Category>>(
                  future: ref.read(categoryListModel).getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final categories = snapshot.data!;
                      selectedCategory = categories.first;
                      return TodoForm(
                        todo: todo,
                        categories: categories,
                        selectedCategory: selectedCategory,
                        formKey: formKey,
                        taskNameController: taskNameController,
                        descriptionController: descriptionController,
                        dateTimeController: dateTimeController,
                        onCategoryChanged: (category) {
                          selectedCategory = category;
                        },
                        onDateSaved: (dateTime) {
                          dateTimeController.value = dateTime;
                        },
                        onSavePressed: () {
                          if (formKey.currentState != null &&
                              formKey.currentState!.validate()) {
                            final Todo newTodo = Todo(
                              id: DateTime.now().toString(),
                              isDone: false,
                              dueDate: dateTimeController.value,
                              description: descriptionController.text,
                              title: taskNameController.text,
                              categoryId: selectedCategory!.id,
                            );
                            debugPrint('New isDone: ${newTodo.isDone}');
                            debugPrint('New dueDate: ${newTodo.dueDate}');
                            debugPrint(
                                'New description: ${newTodo.description}');
                            debugPrint('New title: ${newTodo.title}');
                            debugPrint('New categoryId: ${newTodo.categoryId}');

                            ref.read(todosListState.notifier).addTodo(newTodo);
                            Navigator.of(context).pop();
                          }
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }))),
    );
  }
}
