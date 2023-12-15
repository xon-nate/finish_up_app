import 'package:finish_up_app/features/todo/presentation/widgets/pick_date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/domain/entities/category.dart';
import '../../domain/entities/todo.dart';
import '../controllers/date_time_controller.dart';
import 'centered_button.dart';
import 'labeled_input_widget.dart';

class TodoForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController taskNameController;
  final TextEditingController descriptionController;
  final DateTimeController dateTimeController;
  final Function(Category?) onCategoryChanged;
  final Function(DateTime?) onDateSaved;
  final Function() onSavePressed;
  final Todo? todo;
  final List<Category> categories;
  final Category? selectedCategory;
  const TodoForm({
    super.key,
    required this.categories,
    required this.formKey,
    required this.taskNameController,
    required this.descriptionController,
    required this.dateTimeController,
    required this.onCategoryChanged,
    required this.onDateSaved,
    required this.onSavePressed,
    required this.selectedCategory,
    this.todo,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoFormState();
}

class _TodoFormState extends ConsumerState<TodoForm> {
  late Category? selectedCategory;
  late Category? initialSelectedCategory;

  @override
  void initState() {
    super.initState();
    initialSelectedCategory = widget.selectedCategory;
    selectedCategory = initialSelectedCategory;

    if (widget.todo == null) {
      selectedCategory = widget.selectedCategory;
    } else {
      selectedCategory = widget.categories.firstWhere(
        (category) => category.id == widget.todo!.categoryId,
        orElse: () => widget.selectedCategory!,
      );
    }

    widget.taskNameController.text = widget.todo?.title ?? '';
    widget.descriptionController.text = widget.todo?.description ?? '';
    widget.dateTimeController.value = widget.todo?.dueDate;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                value: selectedCategory,
                onChanged: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                  widget.onCategoryChanged(category);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
                items: widget.categories.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
              )),
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
