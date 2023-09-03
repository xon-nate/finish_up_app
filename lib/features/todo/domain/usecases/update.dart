import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class UpdateTodoUseCase extends UseCase<Todo, Todo> {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Todo params) async {
    return await repository.updateTodo(params);
  }
}
