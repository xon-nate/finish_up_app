import 'package:finish_up_app/features/todo/presentation/screens/edit_todo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/category/presentation/screens/category_screen.dart';
import '../../features/todo/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/edit/:todoId',
      builder: (context, state) => EditTodoScreen(
        todoId: state.pathParameters['todoId']!,
      ),
    ),
    GoRoute(
      path: '/category/:categoryId',
      builder: (context, state) => CategoryScreen(
        categoryId: state.pathParameters['categoryId']!,
      ),
    ),
  ],
);
