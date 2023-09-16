import 'package:finish_up_app/features/category/presentation/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../category/domain/entities/category.dart';
import '../providers/todo_controller.dart';
import '../widgets/todo_item.dart';
import '../widgets/todo_item_shimmer.dart';
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
        body: const TabBarView(
          children: [
            Center(
              child: Text('Home'),
            ),
            TodoList(),
            Center(
              child: Text('Categories'),
            ),
          ],
        ),
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

        return todos.isEmpty
            //if empty return msg that says no tasks yet, add here and hsows an arrow towards the floating action button
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No tasks yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111111),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Add a task to get started',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7B8088),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: todos.length,
                itemBuilder: (_, index) {
                  final todo = todos[index];
                  final categoryFuture = ref
                      .watch(categoryListModel)
                      .getCategoryById(todo.categoryId);

                  return FutureBuilder<Category>(
                    future: categoryFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Return shimmer widget here while loading the category
                        return const TodoListShimmer();
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

class TodoListShimmer extends StatelessWidget {
  const TodoListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4, // Show 4 shimmer placeholders
      itemBuilder: (_, __) {
        return const TodoItemShimmer();
      },
    );
  }
}
