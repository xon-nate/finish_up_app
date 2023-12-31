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
  final ProviderContainer ref;

  TodosStateNotifier({required this.ref}) : super(Todos(todos: [])) {
    getTodos().then((value) {
      state = Todos(todos: value);
    });
  }

  //get state
  List<Todo> get todos => state.todos;

  Future<void> addTodo(Todo todo) async {
    await ref.read(addTodoUseCaseProvider).call(
          Params(
            todo,
          ),
        );
    await getTodos().then((value) {
      state = Todos(todos: value);
    });
  }

  Future<void> updateTodo(Todo todo) async {
    await ref.read(updateTodoUseCaseProvider).call(
          Params(
            todo,
          ),
        );

    await getTodos().then((value) {
      state = Todos(todos: value);
    });
  }

  Future<void> updateTodos() async {
    final todos = await ref.read(getAllTodosUseCaseProvider).call(NoParams());
    state = Todos(todos: todos.fold((l) => [], (r) => r));
  }

  Future<bool> updateTodoStatus(Todo todo) async {
    final result = await ref.read(updateTodoStatusUseCaseProvider).call(
          Params(
            todo,
          ),
        );
    await getTodos().then((value) {
      state = Todos(todos: value);
    });
    return result.fold((l) => false, (r) => true);
  }

  //get todos
  Future<List<Todo>> getTodos() async {
    final todos = await ref.read(getAllTodosUseCaseProvider).call(NoParams());
    return todos.fold(
      (l) => [],
      (r) => r,
    );
  }

  Future<bool> deleteTodo(id) async {
    final result = await ref.read(deleteTodoUseCaseProvider).call(Params(id));
    await getTodos().then((value) {
      state = Todos(todos: value);
    });
    return result.fold((l) => false, (r) => true);
  }
}

final todosListState = StateNotifierProvider<TodosStateNotifier, Todos>((ref) {
  return TodosStateNotifier(ref: ref.container);
});

final todosListModel = Provider<TodosStateNotifier>((ref) {
  return ref.watch(todosListState.notifier);
});
