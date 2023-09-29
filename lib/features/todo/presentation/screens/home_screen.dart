import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/presentation/screens/add_screen.dart';
import '../../../category/presentation/widgets/category_list.dart';
import '../widgets/todo_list.dart';
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
  Widget build(BuildContext context, WidgetRef ref) {
    final TabController tabController = DefaultTabController.of(context);
    tabController.addListener(() {
      ref
          .read(selectedTabProvider.notifier)
          .update((state) => state = tabController.index);
    });
    return Scaffold(
      floatingActionButton: Visibility(
        visible: ref.watch(selectedTabProvider) != 0,
        child: FloatingActionButton(
          onPressed: () {
            if (ref.watch(selectedTabProvider) == 1) {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return const AddTodoBottomSheet();
                  });
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddCategoryScreen(),
                ),
              );
            }
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
          Center(child: Text('Home')),
          TodoList(),
          CategoriesList(),
        ],
      ),
    );
  }
}
