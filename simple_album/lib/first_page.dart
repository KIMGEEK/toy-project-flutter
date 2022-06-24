import 'package:flutter/material.dart';
import 'package:simple_album/image.dart';

class FirstApp extends StatelessWidget {
  final List<Img>? list;
  const FirstApp({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: ListView.builder(
          itemBuilder: (context, position) {
            return GestureDetector(
              child: Card(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      list![position].imagePath!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    Text(list![position].date!)
                  ],
                ),
              ),
              onTap: () {
                AlertDialog dialog = AlertDialog(
                  content: Image.asset(list![position].imagePath!),
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog);
              },
            );
          },
          itemCount: list!.length,
        ),
      )),
    );
  }
}
