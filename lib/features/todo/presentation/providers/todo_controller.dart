// ignore_for_file: unused_import

import 'package:finish_up_app/features/todo/presentation/controllers/date_time_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/usecase.dart';
import '../../data/repository/todo_local_repo_impl.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repository/todo_repository.dart';
import '../../domain/usecases/add.dart';
import '../../domain/usecases/delete.dart';
import '../../domain/usecases/get_all.dart';
import '../../domain/usecases/module.dart';
import '../../domain/usecases/update.dart';
import '../../domain/usecases/update_status.dart';

class Todos {
  final List<Todo> todos;

  Todos({
    required this.todos,
  });

  @override
  String toString() => 'Todos(todos: $todos)';
}

class TodosStateNotifier extends StateNotifier<Todos> {
  // final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = DateTimeController();

  final ProviderContainer ref;

  TodosStateNotifier({required this.ref}) : super(Todos(todos: [])) {
    getTodos().then((value) {
      state = Todos(todos: value);
    });
    debugPrint("TodosStateNotifier");
  }

  //get state
  List<Todo> get todos => state.todos;

  Future<void> addTodo(Todo todo) async {
    debugPrint(
        'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA${todo.dueDate.toString()}');
    debugPrint(state.todos.toString());
    await ref.read(addTodoUseCaseProvider).call(
          Params(
            todo,
          ),
        );
    await getTodos().then((value) {
      state = Todos(todos: value);
    });
    debugPrint(state.todos.toString());
  }

  //get todos
  Future<List<Todo>> getTodos() async {
    final todos = await ref.read(getAllTodosUseCaseProvider).call(NoParams());
    return todos.fold((l) => [], (r) => r);
  }
}

final todosListState = StateNotifierProvider<TodosStateNotifier, Todos>((ref) {
  return TodosStateNotifier(ref: ref.container);
});

final todosListModel = Provider<TodosStateNotifier>((ref) {
  return ref.watch(todosListState.notifier);
});
