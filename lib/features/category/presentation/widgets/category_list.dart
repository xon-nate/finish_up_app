import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/category.dart';
import '../providers/categories_provider.dart';
import 'category_item.dart';

final categoriesFutureProvider = FutureProvider<List<Category>>((ref) async {
  final categories = ref.watch(categoryListState).categories;
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
            return Dismissible(
              key: UniqueKey(), // Unique key for each item
              onDismissed: (direction) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Category'),
                    content: const Text(
                        'Are you sure you want to delete this category?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          ref
                              .read(categoryListModel)
                              .deleteCategory(category.id);
                          Navigator.pop(ctx);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                );
              },
              background: Container(
                  color: Colors.red), // Optional: Swipe to delete background
              child: InkWell(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Delete Category'),
                        content: const Text(
                            'Are you sure you want to delete this category?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(categoryListModel)
                                  .deleteCategory(category.id);
                              Navigator.pop(ctx);
                            },
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CategoryItemWidget(
                  key: ValueKey(category.id),
                  category: category,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
