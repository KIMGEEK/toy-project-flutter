import 'package:flutter/material.dart';
import 'package:simple_album/image.dart';

class ThirdApp extends StatefulWidget {
  @override
  State<ThirdApp> createState() => _ThirdAppState();
  List<Img>? list;

  ThirdApp({Key? key, this.list}) : super(key: key);
}

class _ThirdAppState extends State<ThirdApp> {
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TextField(
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                        child: Image.asset('assets/images/1.jpg', width: 80),
                        onTap: () {
                          _imagePath = 'assets/images/1.jpg';
                        }),
                    GestureDetector(
                        child: Image.asset('assets/images/2.jpg', width: 80),
                        onTap: () {
                          _imagePath = 'assets/images/2.jpg';
                        }),
                    GestureDetector(
                        child: Image.asset('assets/images/3.jpg', width: 80),
                        onTap: () {
                          _imagePath = 'assets/images/3.jpg';
                        }),
                    GestureDetector(
                        child: Image.asset('assets/images/4.jpg', width: 80),
                        onTap: () {
                          _imagePath = 'assets/images/4.jpg';
                        }),
                    GestureDetector(
                        child: Image.asset('assets/images/5.jpg', width: 80),
                        onTap: () {
                          _imagePath = 'assets/images/5.jpg';
                        }),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  final String img_now =
                      '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}';
                  var img = Img(imagePath: _imagePath, date: img_now);

                  AlertDialog dialog = AlertDialog(
                    content: const Text('Add the Image?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            widget.list?.add(img);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
                child: const Text('Add')),
          ],
        )),
      ),
    );
  }
}
