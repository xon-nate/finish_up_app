import 'package:finish_up_app/features/todo/presentation/screens/edit_todo.dart';
import 'package:go_router/go_router.dart';

import '../../features/todo/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => const EditTodoScreen(),
    ),
  ],
);
