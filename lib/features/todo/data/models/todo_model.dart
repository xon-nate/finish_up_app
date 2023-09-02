import 'package:finish_up_app/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required String id,
    required String categoryId,
    required String title,
    required String description,
    required DateTime? dueDate,
    required bool isDone,
  }) : super(
          categoryId: categoryId,
          dueDate: dueDate,
          id: id,
          title: title,
          description: description,
          isDone: isDone,
        );

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: json['dueDate'] as DateTime?,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'isDone': isDone,
    };
  }

  Todo toEntity() {
    return Todo(
      id: id,
      categoryId: categoryId,
      dueDate: dueDate,
      title: title,
      description: description,
      isDone: isDone,
    );
  }
}
