import 'package:finish_up_app/features/category/presentation/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/domain/entities/category.dart';
import '../providers/todo_controller.dart';
import '../widgets/todo_item.dart';
import 'add_todo.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return const AddTodoBottomSheet();
              },
            );
          },
          // backgroundColor: const Color(0xFF006ED4),
          child: const Icon(
            Icons.add,
            size: 30,
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
              Scaffold.of(context).openDrawer();
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
        // body: Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: ListView(
        //     physics: const BouncingScrollPhysics(),
        //     shrinkWrap: true,
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Latest Tasks',
        //             style: Theme.of(context).textTheme.displayLarge,
        //           ),
        //           const SizedBox(
        //             height: 16,
        //           ),
        //           TodoItemWidget(
        //             key: UniqueKey(),
        //             isCompleted: false,
        //             categoryName: 'General',
        //             categoryIcon: Icons.home_rounded,
        //           ),
        //           const SizedBox(
        //             height: 16,
        //           ),
        //           TodoItemWidget(
        //             key: UniqueKey(),
        //             isCompleted: true,
        //             categoryName: 'University Studies',
        //             categoryIcon: Icons.local_grocery_store_rounded,
        //           ),
        //           const SizedBox(
        //             height: 16,
        //           ),
        //           TodoItemWidget(
        //             key: UniqueKey(),
        //             isCompleted: false,
        //             categoryName: 'General',
        //             categoryIcon: Icons.home_rounded,
        //           ),
        //           const SizedBox(
        //             height: 16,
        //           ),
        //           TodoItemWidget(
        //             key: UniqueKey(),
        //             isCompleted: true,
        //             categoryName: 'University Studies',
        //             categoryIcon: Icons.local_grocery_store_rounded,
        //           ),
        //           const SizedBox(
        //             height: 16,
        //           ),
        //           TodoItemWidget(
        //             key: UniqueKey(),
        //             isCompleted: false,
        //             categoryName: 'General',
        //             categoryIcon: Icons.home_rounded,
        //           ),
        //           const SizedBox(
        //             height: 16,
        //           ),
        //           TodoItemWidget(
        //             key: UniqueKey(),
        //             isCompleted: true,
        //             categoryName: 'University Studies',
        //             categoryIcon: Icons.local_grocery_store_rounded,
        //           ),
        //           const SizedBox(
        //             height: 16,
        //           ),
        //           // Consumer(
        //           //   builder: (_, WidgetRef ref, __) {
        //           //     return Text(
        //           //       ref.watch(todoController).toString(),
        //           //       style: const TextStyle(
        //           //         fontSize: 100,
        //           //         fontFamily: 'Kumbh',
        //           //         fontWeight: FontWeight.w900,
        //           //       ),
        //           //     );
        //           //   },
        //           // ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        //padding listview builder get all todos
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: ref.watch(todosListState).todos.length,
            itemBuilder: (_, index) {
              final todo = ref.watch(todosListModel).todos[index];
              final categoryFuture =
                  ref.watch(categoryListModel).getCategoryById(todo.categoryId);

              return FutureBuilder<Category>(
                future: categoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Return a loading indicator while fetching data
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle error state
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final category = snapshot.data;

                    return TodoItemWidget(
                      key: ValueKey(todo.id),
                      todo: todo,
                      isCompleted: todo.isDone,
                      category: category!,
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
