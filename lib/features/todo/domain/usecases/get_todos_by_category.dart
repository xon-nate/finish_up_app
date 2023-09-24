import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../../../category/domain/entities/category.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class GetTodosByCategory extends UseCase<List<Todo>, Params> {
  final TodoRepository repository;

  GetTodosByCategory({required this.repository});

  @override
  Future<Either<Failure, List<Todo>>> call(Params params) async {
    return await repository.getTodosByCategory(params.data);
  }
}
