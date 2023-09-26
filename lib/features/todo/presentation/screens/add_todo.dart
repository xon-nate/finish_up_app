import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/domain/entities/category.dart';
import '../../../category/presentation/providers/categories_provider.dart';
import '../../domain/entities/todo.dart';
import '../controllers/date_time_controller.dart';
import '../providers/todo_controller.dart';
import '../widgets/todo_form.dart';

final categoryListModelProvider = Provider<CategoryStateNotifier>((ref) {
  return ref.watch(categoryListState.notifier);
});

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
    // selectedCategory = categories.first;x

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Add Todo',
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              FutureBuilder<List<Category>>(
                  future: ref.read(categoryListModel).getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final categories = snapshot.data!;
                      selectedCategory = categories.first;
                      return TodoForm(
                        taskNameController: taskNameController,
                        descriptionController: descriptionController,
                        dateTimeController: dateTimeController,
                        onCategoryChanged: (category) {
                          selectedCategory = category;
                        },
                        onDateSaved: (dateTime) {
                          dateTimeController.value = dateTime;
                          debugPrint(
                              'onDateSaved: ${dateTimeController.value}');
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
                        formKey: formKey,
                        categories: categories,
                        selectedCategory: selectedCategory,
                        todo: null,
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
