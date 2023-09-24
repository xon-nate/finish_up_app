import 'package:finish_up_app/features/category/presentation/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryScreen extends ConsumerWidget {
  final String categoryId;
  const CategoryScreen({required this.categoryId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryId),
      ),
      body: ListView.builder(
        itemCount: ref.watch(categoryListState).categories.length,
        itemBuilder: (context, index) {
          final category = ref.watch(categoryListState).categories[index];
          return ListTile(
            title: Text(category.name),
            subtitle: Text(category.id),
          );
        },
      ),
    );
  }
}
