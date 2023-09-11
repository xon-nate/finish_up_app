//module.dart of riverpod provider of all usecases

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/todo_local_repo_impl.dart';
import 'add.dart';
import 'delete.dart';
import 'get_all.dart';
import 'update.dart';
import 'update_status.dart';

final addTodoUseCaseProvider = Provider<AddTodoUseCase>(
  (ref) {
    //assure print statement is executed before returning the usecase
    debugPrint("addTodoUseCaseProvider");
    return AddTodoUseCase(
      ref.read(todoLocalRepositoryProvider),
    );
  },
);

final updateTodoUseCaseProvider = Provider<UpdateTodoUseCase>(
  (ref) => UpdateTodoUseCase(
    ref.read(todoLocalRepositoryProvider),
  ),
);

final deleteTodoUseCaseProvider = Provider<DeleteTodoUseCase>(
  (ref) => DeleteTodoUseCase(
    ref.read(todoLocalRepositoryProvider),
  ),
);

final updateTodoStatusUseCaseProvider = Provider<UpdateTodoStatusUseCase>(
  (ref) => UpdateTodoStatusUseCase(
    ref.read(todoLocalRepositoryProvider),
  ),
);

final getAllTodosUseCaseProvider = Provider<GetAllTodosUseCase>(
  (ref) => GetAllTodosUseCase(
    ref.read(todoLocalRepositoryProvider),
  ),
);
