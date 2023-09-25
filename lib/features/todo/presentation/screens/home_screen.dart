import 'package:finish_up_app/features/category/presentation/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../category/domain/entities/category.dart';
import '../providers/todo_controller.dart';
import '../widgets/todo_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/todo_item_shimmer.dart';
import 'add_todo.dart';

// Create a provider that contains the selected index of the tab bar view
final selectedTabProvider = StateProvider<int>((ref) => 1);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      initialIndex:
          ref.watch(selectedTabProvider), // Use .state to access the value
      child: const HomeScaffold(),
    );
  }
}

class HomeScaffold extends ConsumerWidget {
  const HomeScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final TabController tabController = DefaultTabController.of(context);
    tabController.addListener(() {
      ref
          .read(selectedTabProvider.notifier)
          .update((state) => state = tabController.index);
    });
    return Scaffold(
      floatingActionButton: Visibility(
        visible: ref.watch(selectedTabProvider) == 1,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return const AddTodoBottomSheet();
              },
            );
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFECECEC),
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Color(0xFF111111),
          ),
          onPressed: () {
            //TODO implement drawer
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Color(0xFF111111),
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
        title: const Text(
          'Finish Up',
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: const TabBar(
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111111),
          ),
          labelColor: Color(0xFF111111),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF7B8088),
          ),
          tabs: [
            Tab(
              text: 'Home',
            ),
            Tab(
              text: 'Tasks',
            ),
            Tab(
              text: 'Categories',
            ),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Center(
            child: Text('Home'),
          ),
          TodoList(),
          CategoriesList(),
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final todos = ref.watch(todosListState).todos;

        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (_, index) {
            final todo = todos[index];
            final categoryFuture =
                ref.watch(categoryListModel).getCategoryById(todo.categoryId);
            //wait 10 seconds

            return FutureBuilder<Category>(
              future: categoryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (_, __) {
                      return const TodoItemShimmer();
                    },
                  );
                } else if (snapshot.hasError) {
                  // Handle error state
                  return Text('Error: ${snapshot.error}');
                } else {
                  final category = snapshot.data;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: TodoItemWidget(
                      key: ValueKey(todo.id),
                      todo: todo,
                      isCompleted: todo.isDone,
                      category: category!,
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}

class CategoriesList extends ConsumerWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return FutureBuilder<List<Category>>(
      future: ref.read(categoryListModel).getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still running
          return GridView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (_, __) {
              return const ShimmerCategoryItemWidget();
            },
          );
        } else if (snapshot.hasError) {
          // If there's an error
          return Text('Error: ${snapshot.error}');
        } else {
          // If the future has completed successfully
          final categories = snapshot.data;

          if (categories == null || categories.isEmpty) {
            return const Text('No categories available.');
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: GridView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (_, index) {
                final category = categories[index];

                return CategoryItemWidget(category: category);
              },
            ),
          );
        }
      },
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: InkWell(
        onTap: () {
          context.push('/category/${category.id}');
        },
        child: Card(
          color: category.categoryColor.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: category.categoryColor.darkColor,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  category.icon,
                  color: category.categoryColor.darkColor,
                  size: 45,
                ),
                Text(
                  category.name,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerCategoryItemWidget extends StatelessWidget {
  const ShimmerCategoryItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!, // Shimmer base color
        highlightColor: Colors.grey[100]!, // Shimmer highlight color
        child: Card(
          color: Colors.white, // Background color for the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(
              color: Colors.grey, // Border color
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[100], // Icon background color
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(
                  height: 16.0, // Height of the shimmering text
                  child: Container(
                    color: Colors.grey[100], // Text background color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
