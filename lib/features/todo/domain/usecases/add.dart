import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class AddTodoUseCase extends UseCase<Todo, Todo> {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Todo params) async {
    return await repository.addTodo(params);
  }
}
