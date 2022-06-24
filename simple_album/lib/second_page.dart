import 'package:flutter/material.dart';
import 'package:simple_album/image.dart';

class SecondApp extends StatelessWidget {
  final List<Img>? list;
  const SecondApp({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Container(
                      child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Image.asset(
                            list![index].imagePath!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          )));
                }),
                itemCount: list!.length,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Container(
                      child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Image.asset(
                            list![index].imagePath!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          )));
                }),
                itemCount: list!.length,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Container(
                      child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Image.asset(
                            list![index].imagePath!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          )));
                }),
                itemCount: list!.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
