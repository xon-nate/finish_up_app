import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class UpdateTodoStatusUseCase extends UseCase<bool, Todo> {
  final TodoRepository repository;

  UpdateTodoStatusUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Todo params) async {
    return await repository.updateTodoStatus(params);
  }
}
