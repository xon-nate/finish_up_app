import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class AddTodoUseCase extends UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  @override
  // params is the todo to be added
  Future<Either<Failure, Todo>> call(Params params) async {
    print("AddTodoUseCase");
    return await repository.addTodo(params.data);
  }
}
