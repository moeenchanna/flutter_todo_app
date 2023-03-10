import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';
import '../todo_repository.dart';
import '../todo_repository_firestore.dart';


class TodoProvider extends ChangeNotifier {
  final TodoRepository repository;

  TodoProvider({
    required this.repository,
  });

  Stream<List<Todo>> todo() {
    return repository.todo();
  }

  Future<void> addTodo({
    required String title,
    required String description,
  }) async {
    await repository.addTodo(
      title: title,
      description: description,
    );
    notifyListeners();
  }
}

final todoProvider = ChangeNotifierProvider<TodoProvider>(create: (ref) {
  final repository = TodoRepositoryFirestore();
  return TodoProvider(repository: repository);
});

