class Todo {
  final String id;
  final String categoryId;
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isDone;

  const Todo({
    required this.categoryId,
    required this.dueDate,
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  @override
  String toString() {
    return 'Todo(id: $id, categoryId: $categoryId, title: $title, description: $description, dueDate: $dueDate, isDone: $isDone)';
  }

  //create copywith
  Todo copyWith({
    String? id,
    String? categoryId,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
    );
  }
}
