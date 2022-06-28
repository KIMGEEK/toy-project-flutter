import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/todo_list.dart';
import 'package:todolist/sub_detail.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => TodoList(),
        '/sub_detail': (context) => SubDetail(),
      },
    );
  }
}
