import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/category_local_repo_impl.dart';
import 'add.dart';
// import 'delete.dart';
import 'get_all.dart';
import 'get.dart';
// import 'update.dart';

final addCategoryUseCaseProvider = Provider.autoDispose<AddCategoryUseCase>(
  (ref) {
    //assure print statement is executed before returning the usecase
    debugPrint("addCategoryUseCaseProvider");
    return AddCategoryUseCase(
      ref.read(categoryLocalRepositoryProvider),
    );
  },
);

final getAllCategoriesUseCaseProvider =
    Provider.autoDispose<GetAllCategoriesUseCase>(
  (ref) => GetAllCategoriesUseCase(
    ref.read(categoryLocalRepositoryProvider),
  ),
);

final getCategoryByIdUseCaseProvider = Provider.autoDispose<GetCategoryUseCase>(
  (ref) => GetCategoryUseCase(
    ref.read(categoryLocalRepositoryProvider),
  ),
);
