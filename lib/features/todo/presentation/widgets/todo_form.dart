import 'package:finish_up_app/features/todo/presentation/widgets/pick_date_time_widget.dart';
import 'package:flutter/material.dart';

import '../../../category/domain/entities/category.dart';
import '../../domain/entities/todo.dart';
import '../controllers/date_time_controller.dart';
import 'centered_button.dart';
import 'labeled_input_widget.dart';

class TodoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController taskNameController;
  final TextEditingController descriptionController;
  final DateTimeController dateTimeController;
  final List<Category> categories;
  final Function(Category?) onCategoryChanged;
  final Function(DateTime?) onDateSaved;
  final Function() onSavePressed;
  final Todo? todo;
  late final Category? selectedCategory;

  TodoForm({
    Key? key,
    required this.formKey,
    required this.taskNameController,
    required this.descriptionController,
    required this.dateTimeController,
    required this.categories,
    required this.onCategoryChanged,
    required this.onDateSaved,
    required this.onSavePressed,
    this.todo,
  }) : super(key: key) {
    late final Category? initialCategory; // Use 'late final' local variable

    // Initialize the controllers and selected category based on the 'Todo' object
    if (todo != null) {
      taskNameController.text = todo!.title;
      descriptionController.text = todo!.description;
      dateTimeController.value = todo!.dueDate;

      // Set initialCategory to the category of the 'Todo' object
      initialCategory = categories.firstWhere(
        (category) => category.id == todo!.categoryId,
        orElse: () =>
            categories.firstWhere((category) => category.name == 'General'),
      );
    } else {
      // If 'todo' is null, set initialCategory to 'General'
      initialCategory =
          categories.firstWhere((category) => category.name == 'General');
    }

    selectedCategory = initialCategory; // Assign to 'selectedCategory'
  }

  @override
  TodoFormState createState() => TodoFormState();
}

class TodoFormState extends State<TodoForm> {
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    // Initialize selectedCategory based on the 'Todo' object
    if (widget.todo != null) {
      selectedCategory = widget.categories.firstWhere(
        (category) => category.id == widget.todo!.categoryId,
        orElse: () => widget.categories
            .firstWhere((category) => category.name == 'General'),
      );
      debugPrint('selectedCategory: $selectedCategory');
    } else {
      // If 'todo' is null, set selectedCategory to 'General'
      selectedCategory = widget.categories
          .firstWhere((category) => category.name == 'General');
    }
  }

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
              value: widget.selectedCategory,
              onChanged: widget.onCategoryChanged,
            ),
          ),
          DateTimeFormField(
            onSaved: (dateTime) {
              widget.onDateSaved(dateTime);
            },
            initialValue: widget.dateTimeController.value,
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
            label: widget.todo == null ? 'Add Task' : 'Save Changes',
          ),
        ],
      ),
    );
  }
}
