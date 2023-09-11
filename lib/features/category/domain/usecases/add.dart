import 'package:dartz/dartz.dart';
import 'package:finish_up_app/features/category/domain/repository/category_repository.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/category.dart';

class AddCategoryUseCase extends UseCase<Category, Params<Category>> {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  @override
  // params is the category to be added
  Future<Either<Failure, Category>> call(Params params) async {
    print("AddCategoryUseCase");
    return await repository.addCategory(params.data);
  }
}
