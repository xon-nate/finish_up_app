import 'package:finish_up_app/core/utils/usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/module.dart';

class Categories {
  final List<Category> categories;
  Categories({
    required this.categories,
  });
  @override
  String toString() => 'Categories(categories: $categories)';
}

class CategoryStateNotifier extends StateNotifier<Categories> {
  final ProviderContainer ref;

  CategoryStateNotifier({required this.ref})
      : super(Categories(categories: [])) {
    loadCategories();
  }

  void loadCategories() async {
    var categories = await getCategories();
    state = Categories(categories: categories);
    print(
        "---------------------------------------------------------CategoryStateNotifier: $categories $state");
  }

  Future<List<Category>> getCategories() async {
    final categories =
        await ref.read(getAllCategoriesUseCaseProvider).call(NoParams());
    return await categories.fold(
      (l) => [],
      (r) => r,
    );
  }

  List<Category> get categories => state.categories;

  void addCategory(Category newCategory) async {
    final addedCategory =
        await ref.read(addCategoryUseCaseProvider).call(Params(newCategory));
    debugPrint('BIM BIM BAM BAM $addedCategory');
    await getCategories()
        .then((value) => {state = Categories(categories: value)});
    debugPrint(state.categories.toString());
  }

  void updateCategory() {}

  void deleteCategory(String id) async {
    await ref.read(deleteCategoryUseCaseProvider).call(Params(id));
    await getCategories()
        .then((value) => {state = Categories(categories: value)});
  }

  Future<Category> getCategoryById(String id) async {
    final category =
        await ref.read(getCategoryByIdUseCaseProvider).call(Params(id));
    debugPrint("CategoryStateNotifier: $category");
    return await category.fold(
        (l) => Category(
              id: 0.toString(),
              name: "Error",
              colorIndex: 0,
              iconIndex: 0,
            ),
        (r) => r);
  }
}

final categoryListState =
    StateNotifierProvider<CategoryStateNotifier, Categories>(
  (ref) {
    return CategoryStateNotifier(ref: ref.container);
  },
);

final categoryListModel = Provider<CategoryStateNotifier>(
  (ref) {
    return ref.watch(categoryListState.notifier);
  },
);

final categoryFutureListProvider = FutureProvider<List<Category>>((ref) async {
  return await ref.watch(categoryListState.notifier).getCategories();
});
