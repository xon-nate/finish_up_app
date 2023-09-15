import 'package:dartz/dartz.dart';

import 'package:finish_up_app/core/errors/errors.dart';

import 'package:finish_up_app/features/category/domain/entities/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/category_repository.dart';
import '../database/category_local_db.dart';

class CategoryLocalRepositoryImpl implements CategoryRepository {
  //declare local db inst
  final CategoryLocalDataBase localDataBase;
  CategoryLocalRepositoryImpl({required this.localDataBase});

  @override
  Future<Either<Failure, Category>> addCategory(Category newCategory) async {
    try {
      //open database
      final db = await localDataBase.openDB();
      //insert new category
      final id = await localDataBase.addCategory(newCategory);
      //get new category
      final category = await localDataBase.getCategory(id);
      //close database
      await db.close();
      //return new category
      return Right(category);
    } on Exception catch (e) {
      return Left(
        Failure(
          message: 'Error adding category: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Category>> deleteCategoryById(String id) async {
    // get category by id
    final category = await localDataBase.getCategory(int.parse(id));
    await localDataBase.deleteCategory(int.parse(id));
    return Right(category);
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      //open database
      final db = await localDataBase.openDB();
      //get categories
      final categories = await localDataBase.getCategories();
      //close database
      await db.close();
      //return categories
      return Right(categories);
    } on Exception catch (e) {
      return Left(
        Failure(
          message: 'Error getting categories: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Category>> updateCategory(
      Category updatedCategory) async {
    try {
      //open database
      final db = await localDataBase.openDB();
      //update category
      await localDataBase.updateCategory(updatedCategory);
      //get updated category
      final category =
          await localDataBase.getCategory(int.parse(updatedCategory.id));
      //close database
      await db.close();
      //return updated category
      return Right(category);
    } on Exception catch (e) {
      return Left(
        Failure(
          message: 'Error updating category: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(String id) async {
    return Right(await localDataBase.getCategory(int.parse(id)));
  }
}

// categoryLocalRepositoryProvider
final categoryLocalRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryLocalRepositoryImpl(
    localDataBase: ref.watch(categoryLocalDataBaseProvider),
  ),
);
