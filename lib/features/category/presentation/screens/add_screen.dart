import 'package:finish_up_app/features/category/presentation/providers/categories_provider.dart';
import 'package:finish_up_app/features/todo/presentation/widgets/labeled_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/category.dart';

final colorIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
final iconIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
final categoryNameProvider = StateProvider.autoDispose<String>((ref) => '');
TextEditingController categoryNameTextController = TextEditingController();

class AddCategoryScreen extends ConsumerWidget {
  const AddCategoryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Category',
          style: TextStyle(color: Color(0xFF111111)),
        ),
        backgroundColor: const Color(0xFFECECEC),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              LabeledInputWidget(
                label: 'Category Name',
                inputWidget: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter category name';
                    }
                    return null;
                  },
                  controller: categoryNameTextController,
                  decoration: const InputDecoration(
                    labelText: 'Category Name',
                    labelStyle: TextStyle(
                      color: Color(0xFF7B8088),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFF006ed4),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFF7B8088),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ColorSelector(),
              const SizedBox(height: 16),
              const IconSelector(),
              const SizedBox(height: 16),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Stack(
                  children: [
                    Card(
                      color: Colors.grey.shade100,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: CategoryColors
                              .categoryPairs[ref.watch(colorIndexProvider)]
                              .color,
                          width: 1.4,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.sizeOf(context).width * 0.1,
                              backgroundColor: CategoryColors
                                  .categoryPairs[ref.watch(colorIndexProvider)]
                                  .color,
                              child: Icon(
                                CategoryColors.categoryIcons[
                                    ref.watch(iconIndexProvider)],
                                color: Colors.white,
                                size: MediaQuery.sizeOf(context).width * 0.1,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Category Name',
                              style: TextStyle(
                                letterSpacing: 1.2,
                                color: Color(0xFF111111),
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: MediaQuery.sizeOf(context).width * 0.1 / 2,
                      child: Container(
                        height: 10,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: CategoryColors
                              .categoryPairs[ref.watch(colorIndexProvider)]
                              .color,
                          boxShadow: [
                            BoxShadow(
                              color: CategoryColors
                                  .categoryPairs[ref.watch(colorIndexProvider)]
                                  .color
                                  .withOpacity(0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final category = Category(
                            id: (
                              ref.watch(categoryListState).categories.length +
                                  1,
                            ).toString(),
                            name: categoryNameTextController.text,
                            colorIndex: ref.read(colorIndexProvider),
                            iconIndex: ref.read(iconIndexProvider),
                          );
                          debugPrint(
                            '${category.colorIndex}+${category.name}+${category.iconIndex}+${category.id}',
                          );
                          ref.read(categoryListModel).addCategory(category);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter category name'),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF2C2C2C)),
                      ),
                      child: const Text(
                        'Add Category',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorSelector extends ConsumerWidget {
  ColorSelector({super.key});
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LabeledInputWidget(
      label: 'Category Color',
      inputWidget: SizedBox(
        height: MediaQuery.of(context).size.height * 0.050 + 16,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          controller: scrollController,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                ref.read(colorIndexProvider.notifier).state = index;
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: CategoryColors.categoryPairs[index].color
                                .withOpacity(0.25),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.025,
                        backgroundColor:
                            CategoryColors.categoryPairs[index].color,
                      ),
                    ),
                  ),
                  if (ref.read(colorIndexProvider) == index)
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class IconSelector extends ConsumerWidget {
  // final WidgetRef ref;

  const IconSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LabeledInputWidget(
      label: 'Category Icon',
      inputWidget: SizedBox(
        height: MediaQuery.of(context).size.height * 0.050 + 16,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                ref.read(iconIndexProvider.notifier).state = index;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: CategoryColors.categoryPairs[index].color
                            .withOpacity(0.25),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.025,
                    backgroundColor: CategoryColors
                        .categoryPairs[ref.watch(colorIndexProvider)].color,
                    child: Icon(
                      CategoryColors.categoryIcons[index],
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
