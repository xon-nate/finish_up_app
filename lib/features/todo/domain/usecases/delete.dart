import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class DeleteTodoUseCase extends UseCase<Todo, Params<String>> {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  @override
  // params is the id of the todo to be deleted
  Future<Either<Failure, Todo>> call(Params params) async {
    return await repository.deleteTodoById(params.data);
  }
}
