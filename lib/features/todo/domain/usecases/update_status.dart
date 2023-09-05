import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class UpdateTodoStatusUseCase extends UseCase<bool, Params<Todo>> {
  final TodoRepository repository;

  UpdateTodoStatusUseCase(this.repository);

  @override
  // params is the todo to be updated with the new status (completed or not)
  Future<Either<Failure, bool>> call(Params<Todo> params) async {
    return await repository.updateTodoStatus(params.data);
  }
}
