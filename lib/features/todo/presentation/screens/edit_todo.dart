import 'package:finish_up_app/features/todo/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../controllers/date_time_controller.dart';
import '../widgets/todo_item_shimmer.dart';

//screen to edit todo item details
class EditTodoScreen extends StatelessWidget {
  const EditTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      //body is form with fields to edit todo item details title, description, category, due date
      body: const TodoListShimmer(),
    );
  }
} // Import your PickDateTimeWidget here

class TodoForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String? initialCategory;
  final DateTimeController dateTimeController;

  const TodoForm({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.initialCategory,
    required this.dateTimeController,
  }) : super(key: key);

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          TextFormField(
            controller: widget.descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description (Optional)',
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedCategory,
            items: <String>[
              'Category 1',
              'Category 2',
              'Category 3',
              // Add your categories here
            ].map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedCategory = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Category',
            ),
          ),
          // PickDateTimeWidget(
          //   dateTimeController: widget.dateTimeController,

          // ),
          ElevatedButton(
            onPressed: () {
              // Handle form submission here
              // Access the values using widget.titleController.text,
              // widget.descriptionController.text,
              // selectedCategory, and widget.dateTimeController.value
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
