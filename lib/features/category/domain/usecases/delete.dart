import 'package:dartz/dartz.dart';
import 'package:finish_up_app/features/category/domain/repository/category_repository.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/category.dart';

class DeleteCategoryUseCase extends UseCase<Category, Params<Category>> {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  @override
  // params is the category to be Delete d
  Future<Either<Failure, Category>> call(Params params) async {
    print("DeleteCategoryUseCase");
    return await repository.deleteCategoryById(params.data);
  }
}
