import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class DeleteTodoUseCase extends UseCase<Todo, String> {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(String params) async {
    return await repository.deleteTodoById(params);
  }
}
