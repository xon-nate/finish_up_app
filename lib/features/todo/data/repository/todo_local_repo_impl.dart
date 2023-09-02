import 'package:dartz/dartz.dart';
import 'package:finish_up_app/features/todo/domain/entities/todo.dart';
import 'package:finish_up_app/features/todo/domain/repository/todo_repository.dart';
import '../../../../core/errors/errors.dart';
import '../database/todo_local_db.dart';
import '../models/todo_model.dart';

class TodoLocalRepositoryImpl implements TodoRepository {
  TodoLocalDataBaseImpl todoLocalDataBase;

  TodoLocalRepositoryImpl({
    required this.todoLocalDataBase,
  });

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
  Future<Either<Failure, Todo>> addTodo(Todo newTodo) async {
    return _execute(() async {
      await todoLocalDataBase.addTodo(
        _mapTodoToModel(newTodo),
      );
      return newTodo;
    });
  }

  @override
  Future<Either<Failure, Todo>> deleteTodoById(String id) async {
    return _execute(() async {
      final todo = await todoLocalDataBase.getTodo(int.parse(id));
      await todoLocalDataBase.deleteTodo(int.parse(id));
      return todo;
    });
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    return _execute(() async {
      final todos = await todoLocalDataBase.getTodos();
      return todos;
    });
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo updatedTodo) async {
    return _execute(() async {
      await todoLocalDataBase.updateTodo(
        _mapTodoToModel(updatedTodo),
      );
      return updatedTodo;
    });
  }

  @override
  Future<Either<Failure, bool>> updateTodoStatus(Todo updatedTodo) async {
    return _execute(() async {
      final result = await todoLocalDataBase.updateTodoStatus(
        int.parse(updatedTodo.id),
        updatedTodo.isDone,
      );
      return result;
    });
  }
}
