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
}
