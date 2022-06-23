import 'package:flutter/material.dart';
import 'package:simple_album/first_page.dart';
import 'package:simple_album/second_page.dart';
import 'package:simple_album/third_page.dart';

void main() => runApp(const MyHomePage());

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('My Album'),
      ),
      body: TabBarView(
        children: <Widget>[FirstApp(), SecondApp(), ThirdApp()],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        labelColor: Colors.lightBlue,
        unselectedLabelColor: Colors.lightBlue[50],
        tabs: const <Tab>[
          Tab(
            icon: Icon(Icons.looks_one),
          ),
          Tab(
            icon: Icon(Icons.looks_two),
          ),
          Tab(
            icon: Icon(Icons.photo_album_outlined),
          ),
        ],
        controller: controller,
      ),
    ));
  }
}
