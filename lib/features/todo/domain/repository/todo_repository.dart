import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, Todo>> addTodo(Todo newTodo);
  Future<Either<Failure, Todo>> updateTodo(Todo updatedTodo);
  Future<Either<Failure, bool>> deleteTodoById(String id);
  Future<Either<Failure, bool>> updateTodoStatus(Todo updatedTodo);
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, List<Todo>>> getTodosByCategory(String categoryId);
}
