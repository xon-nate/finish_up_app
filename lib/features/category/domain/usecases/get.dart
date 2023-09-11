import 'package:dartz/dartz.dart';
import 'package:finish_up_app/features/category/domain/repository/category_repository.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/category.dart';

class GetCategoryUseCase extends UseCase<Category, Params<String>> {
  final CategoryRepository repository;

  GetCategoryUseCase(this.repository);

  @override
  // params is the category to be added
  Future<Either<Failure, Category>> call(Params params) async {
    print("GetCategoryUseCase");
    return await repository.getCategoryById(params.data);
  }
}
