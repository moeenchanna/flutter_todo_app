import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_example/provider/todo_provider.dart';
import 'package:flutter_todo_example/screens/todo_page.dart';
import 'package:flutter_todo_example/todo_repository.dart';
import 'package:provider/provider.dart';

import 'todo_repository_firestore.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TodoRepository>(create: (_) => TodoRepositoryFirestore()),
        ChangeNotifierProvider<TodoProvider>(
          create: (context) => TodoProvider(
            repository: Provider.of<TodoRepository>(context, listen: false),
          ),
        ),
      ],
      child: const MaterialApp(
        title: 'Todo',
        home: TodoPage(),
      ),
    );
  }
}
