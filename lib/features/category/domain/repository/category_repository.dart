import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, Category>> addCategory(Category newCategory);
  Future<Either<Failure, Category>> updateCategory(Category updatedCategory);
  Future<Either<Failure, Category>> deleteCategoryById(String id);
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, Category>> getCategoryById(String id);
}
