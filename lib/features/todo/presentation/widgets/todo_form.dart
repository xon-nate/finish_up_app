import 'dart:async';

import 'package:finish_up_app/features/todo/presentation/widgets/pick_date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/domain/entities/category.dart';
import '../../../category/presentation/providers/categories_provider.dart';
import '../../domain/entities/todo.dart';
import '../controllers/date_time_controller.dart';
import 'centered_button.dart';
import 'labeled_input_widget.dart';

class TodoForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController taskNameController;
  final TextEditingController descriptionController;
  final DateTimeController dateTimeController;
  final List<Category> categories;
  final Function(Category?) onCategoryChanged;
  final Function(DateTime?) onDateSaved;
  final Function() onSavePressed;
  final Todo? todo;
  final Category? selectedCategory;
  const TodoForm({
    super.key,
    required this.formKey,
    required this.taskNameController,
    required this.descriptionController,
    required this.dateTimeController,
    required this.categories,
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
  @override
  Widget build(BuildContext context) {
    // final categories = ref.watch(categoryListState).categories;
    // debugPrint('categories: $categories');
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
          FutureBuilder<Object>(
              future: ref.read(categoryListModel).getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('error');
                } else {
                  final categories = snapshot.data as List<Category>;
                  debugPrint(categories.toString());
                  return LabeledInputWidget(
                    label: 'Category',
                    inputWidget: DropdownButtonFormField<Category>(
                      iconSize: 30,
                      isExpanded: true,
                      menuMaxHeight: MediaQuery.sizeOf(context).height / 3,
                      decoration:
                          const InputDecoration(hintText: 'Select a category'),
                      items: categories.map((category) {
                        print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
                        return DropdownMenuItem<Category>(
                          value: category,
                          child: Text(category.name),
                        );
                      }).toList(),
                      value: widget.selectedCategory,
                      onChanged: widget.onCategoryChanged,
                    ),
                  );
                }
              }),
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
