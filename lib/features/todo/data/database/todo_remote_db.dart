import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo_model.dart';

abstract class TodoRemoteDataBase {
  Future<List<TodoModel>> getTodosRemote();
  Future<TodoModel> addTodoRemote(TodoModel newTodo);
  Future<void> deleteTodoByIdRemote(String id);
  Future<void> updateTodoRemote(TodoModel todo);
  Future<void> updateTodoStatusRemote(TodoModel todo);
  Future<TodoModel> getTodoByIdRemote(String id);
}

class TodoRemoteDataBaseImpl implements TodoRemoteDataBase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todos');

  @override
  Future<TodoModel> addTodoRemote(TodoModel newTodo) async {
    //use todo model toJson and toEntity
    await todosCollection.doc(newTodo.id).set(
          newTodo.toJson(),
        );
    return Future.value(newTodo);
  }

  @override
  Future<void> deleteTodoByIdRemote(String id) async {
    await todosCollection.doc(id).delete();
  }

  @override
  Future<List<TodoModel>> getTodosRemote() async {
    final todos = await todosCollection.get();
    return todos.docs
        .map((e) => TodoModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TodoModel> getTodoByIdRemote(String id) async {
    final todo = await todosCollection.doc(id).get();
    return TodoModel.fromJson(todo.data() as Map<String, dynamic>);
  }

  @override
  Future<void> updateTodoRemote(TodoModel todo) async {
    //convert todo to todoModel
    await todosCollection.doc(todo.id).update(
          todo.toJson(),
        );
  }

  @override
  Future<void> updateTodoStatusRemote(TodoModel todo) async {
    //convert todo to todoModel
    await todosCollection.doc(todo.id).update(
          todo.toJson(),
        );
  }
}
