import 'package:flutter/material.dart';
import 'package:simple_album/first_page.dart';
import 'package:simple_album/second_page.dart';
import 'package:simple_album/third_page.dart';

import 'package:simple_album/image.dart';

void main() => runApp(const MyHomePage());

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Img> imageList = List.empty(growable: true);

  get date => null;

  initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

    for (int i = 1; i <= 7; i++) {
      DateTime now = DateTime.now();
      imageList.add(Img(
          imagePath: "assets/images/${i.toString()}.jpg",
          date: "${now.hour.toString()}:${now.minute.toString()}"));
    }
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
        title: const Text('My Album'),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstApp(list: imageList),
          SecondApp(list: imageList),
          ThirdApp()
        ],
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
          Tab(icon: Icon(Icons.publish_rounded)),
        ],
        controller: controller,
      ),
    ));
  }
}
