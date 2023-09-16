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
            selectedCategory: selectedCategory,
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

class TodoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController taskNameController;
  final TextEditingController descriptionController;
  final DateTimeController dateTimeController;
  final List<Category> categories;
  Category? selectedCategory;
  final Function(Category?) onCategoryChanged;
  final Function(DateTime?) onDateSaved;
  final Function() onSavePressed;

  TodoForm({
    super.key,
    required this.formKey,
    required this.taskNameController,
    required this.descriptionController,
    required this.dateTimeController,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onDateSaved,
    required this.onSavePressed,
  });

  @override
  TodoFormState createState() => TodoFormState();
}

class TodoFormState extends State<TodoForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: widget.formKey,
      child: Column(
        children: [
          LabeledInputWidget(
            label: 'Task Name',
            inputWidget: TextFormField(
              controller: widget.taskNameController,
              decoration: const InputDecoration(
                hintText: 'Enter task name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task name';
                }
                return null;
              },
            ),
          ),
          LabeledInputWidget(
            label: 'Category',
            inputWidget: DropdownButtonFormField<Category>(
              iconSize: 30,
              isExpanded: true,
              menuMaxHeight: MediaQuery.sizeOf(context).height / 3,
              decoration: const InputDecoration(hintText: 'Select a category'),
              items: widget.categories.map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              value:
                  widget.selectedCategory, // Use the selected category variable
              onChanged: (Category? category) {
                setState(() {
                  widget.selectedCategory =
                      category; // Update the selected category
                });
                widget.onCategoryChanged(category);
              },
              validator: (selectedCategory) {
                // Add validator function
                if (selectedCategory == null) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
          ),
          DateTimeFormField(
            onSaved: widget.onDateSaved,
            validator: (dateTime) {
              if (dateTime == null) {
                return 'Please select a date & time';
              }
              return null;
            },
          ),
          LabeledInputWidget(
            label: 'Description',
            inputWidget: TextFormField(
              controller: widget.descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
          ),
          CenteredCallToActionButton(
            onPressed: widget.onSavePressed,
          ),
        ],
      ),
    );
  }
}
