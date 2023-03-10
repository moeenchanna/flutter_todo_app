import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';
import '../provider/todo_provider.dart';


class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  TodosPageState createState() => TodosPageState();
}

class TodosPageState extends State<TodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildTodosList(),
          ),
          _buildAddTodoForm(),
        ],
      ),
    );
  }

  Widget _buildTodosList() {
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        return StreamBuilder<List<Todo>>(
          stream: provider.todo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final todos = snapshot.data!;
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Error loading todos');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildAddTodoForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final title = _titleController.text;
              final description = _descriptionController.text;
              Provider.of<TodoProvider>(context, listen: false).addTodo(
                title: title,
                description: description,
              );
              _titleController.clear();
              _descriptionController.clear();
            },
            child: const Text('Add Todo'),
          ),
        ],
      ),
    );
  }
}
