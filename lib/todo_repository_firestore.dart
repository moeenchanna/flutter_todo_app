import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_example/todo_repository.dart';

import 'model/todo.dart';

class TodoRepositoryFirestore implements TodoRepository {
  final FirebaseFirestore _firestore;

  TodoRepositoryFirestore({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addTodo({
    required String title,
    required String description,
  }) async {
    await _firestore.collection('todo').add({
      'title': title,
      'description': description,
    });
  }

  @override
  Stream<List<Todo>> todo() {
    return _firestore.collection('todo').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Todo(
          title: data['title'],
          description: data['description'],
        );
      }).toList();
    });
  }
}
