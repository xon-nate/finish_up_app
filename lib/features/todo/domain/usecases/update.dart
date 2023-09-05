import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class UpdateTodoUseCase extends UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  @override
  // params is the todo to be updated
  Future<Either<Failure, Todo>> call(Params params) async {
    return await repository.updateTodo(params.data);
  }
}
