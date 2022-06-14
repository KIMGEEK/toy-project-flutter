import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/todo_list.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: Scaffold(
        appBar: AppBar(title: Text('Todo List')),
        body: TodoList(),
      ),
    );
  }
}
