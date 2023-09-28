import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/category.dart';
import '../providers/categories_provider.dart';
import 'category_item.dart';

final categoriesFutureProvider = FutureProvider<List<Category>>((ref) async {
  final categories = await ref.watch(categoryListModel).getCategories();
  return categories;
});

class CategoriesList extends ConsumerWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(categoriesFutureProvider).when(
      error: (error, stackTrace) {
        return Text('Error: $error');
      },
      loading: () {
        return const ShimmerCategoryItemWidget();
      },
      data: (categories) {
        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (_, index) {
            final category = categories[index];
            return CategoryItemWidget(
              key: ValueKey(category.id),
              category: category,
            );
          },
        );
      },
    );
  }
}
