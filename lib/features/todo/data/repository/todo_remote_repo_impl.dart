import 'package:dartz/dartz.dart';
import 'package:finish_up_app/features/todo/domain/entities/todo.dart';
import 'package:finish_up_app/features/todo/domain/repository/todo_repository.dart';

import '../../../../core/errors/errors.dart';
import '../database/todo_remote_db.dart';
import '../models/todo_model.dart';

class TodoRemoteRepositoryImpl implements TodoRepository {
  final TodoRemoteDataBase todoRemoteDataBase;

  TodoRemoteRepositoryImpl({required this.todoRemoteDataBase});

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  TodoModel _mapTodoToModel(Todo todo) {
    return TodoModel(
      id: todo.id,
      categoryId: todo.categoryId,
      title: todo.title,
      description: todo.description,
      dueDate: todo.dueDate,
      isDone: todo.isDone,
    );
  }

  @override
  Future<Either<Failure, TodoModel>> addTodo(Todo newTodo) async {
    return _execute(() async {
      final todoModel = _mapTodoToModel(newTodo);
      await todoRemoteDataBase.addTodoRemote(todoModel);
      return todoModel;
    });
  }

  @override
  Future<Either<Failure, bool>> deleteTodoById(String id) async {
    return _execute(() async {
      final result = await todoRemoteDataBase.deleteTodoByIdRemote(id);
      return result;
    });
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    return _execute(() async {
      final todoModels = await todoRemoteDataBase.getTodosRemote();
      return todoModels;
    });
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo updatedTodo) async {
    return _execute(() async {
      final todoModel = _mapTodoToModel(updatedTodo);
      await todoRemoteDataBase.updateTodoRemote(todoModel);
      return updatedTodo;
    });
  }

  @override
  Future<Either<Failure, bool>> updateTodoStatus(Todo updatedTodo) async {
    return _execute(() async {
      final todoModel = _mapTodoToModel(updatedTodo);
      await todoRemoteDataBase.updateTodoStatusRemote(todoModel);
      return updatedTodo.isDone;
    });
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodosByCategory(String categoryId) {
    // TODO: implement getTodosByCategory
    throw UnimplementedError();
  }
}
