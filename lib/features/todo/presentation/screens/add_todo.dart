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
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Add Task',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
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
                        value: selectedCategory,
                        items: categories.map((category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (Category? value) {
                          if (value != null) {
                            setState(() {
                              selectedCategory = value;
                            });
                          }
                        },
                      ),
                    ),
                    Column(
                      children: [
                        LabeledInputWidget(
                          label: 'Task Due Date',
                          inputWidget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PickDateTimeWidget(
                                dateTimeController: dateTimeController,
                              ),
                              if (formKey.currentState != null &&
                                  dateTimeController.value == null)
                                const Text(
                                  'Please pick a due date and time.',
                                  style: TextStyle(color: Colors.red),
                                ),
                            ],
                          ),
                        ),
                      ],
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
                          if (dateTimeController.value == null) {
                            debugPrint('Please choose a due date');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please choose a due date'),
                              ),
                            );
                          } else {
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
                        } else {
                          debugPrint('Form is invalid');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
