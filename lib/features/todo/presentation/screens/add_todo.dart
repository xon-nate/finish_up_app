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
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                const SizedBox(
                  height: 16,
                ),
                LabeledInputWidget(
                  label: 'Task Name',
                  inputWidget: TextFormField(
                    controller: taskNameController,
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
                    //ceneter dropdown items
                    menuMaxHeight: MediaQuery.sizeOf(context).height / 3,
                    //change color of scroll bar

                    dropdownColor: Colors.grey[300],
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Select a category',
                    ),
                    items: categories.map((category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    // value: selectedCategory,
                    onChanged: (Category? value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
                // PickDateTimeWidget(
                //   dateTimeController: dateTimeController,
                //   formKey: formKey,
                // ),
                DateTimeFormField(
                  onSaved: (dateTime) {
                    dateTimeController.value = dateTime;
                    debugPrint('Date Time: ${dateTimeController.value}');
                  },
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
                    controller: descriptionController,
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save(); // This triggers onSaved

                      debugPrint('Task Name: ${taskNameController.text}');
                      debugPrint('Description: ${descriptionController.text}');
                      debugPrint('Due Date: ${dateTimeController.value}');
                      debugPrint('Category: $selectedCategory');

                      Todo newTodo = Todo(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
