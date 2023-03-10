import 'model/todo.dart';

abstract class TodoRepository {
  Future<void> addTodo({
    required String title,
    required String description,
  });

  Stream<List<Todo>> todo();
}
