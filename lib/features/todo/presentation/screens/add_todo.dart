import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/domain/entities/category.dart';
import '../../../category/presentation/providers/categories_provider.dart';
import '../../domain/entities/todo.dart';
import '../controllers/date_time_controller.dart';
import '../providers/todo_controller.dart';
import '../widgets/centered_button.dart';
import '../widgets/labeled_input_widget.dart';
import '../widgets/pick_date_time_widget.dart';
import '../widgets/todo_form.dart';

class AddTodoBottomSheet extends ConsumerStatefulWidget {
  const AddTodoBottomSheet({Key? key}) : super(key: key);

  @override
  _AddTodoBottomSheetState createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends ConsumerState<AddTodoBottomSheet> {
  final dateTimeController = DateTimeController();
  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryListModel).categories;
    selectedCategory = categories.first;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: TodoForm(
            formKey: formKey,
            taskNameController: taskNameController,
            descriptionController: descriptionController,
            dateTimeController: dateTimeController,
            categories: categories,
            // selectedCategory: selectedCategory,
            onCategoryChanged: (category) {
              selectedCategory = category;
            },
            onDateSaved: (dateTime) {
              dateTimeController.value = dateTime;
              debugPrint('onDateSaved: ${dateTimeController.value}');
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
                debugPrint('New description: ${newTodo.description}');
                debugPrint('New title: ${newTodo.title}');
                debugPrint('New categoryId: ${newTodo.categoryId}');

                ref.read(todosListState.notifier).addTodo(newTodo);
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ),
    );
  }
}
