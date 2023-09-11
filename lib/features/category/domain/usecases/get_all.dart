import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/category.dart';
import '../repository/category_repository.dart';

class GetAllCategoriesUseCase extends UseCase<List<Category>, NoParams> {
  final CategoryRepository repository;

  GetAllCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    print("GetAllCategoriesUseCase");
    return await repository.getCategories();
  }
}
