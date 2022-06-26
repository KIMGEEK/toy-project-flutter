import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  const HttpApp({Key? key}) : super(key: key);

  @override
  State<HttpApp> createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
  String result = '';
  List? data;

  @override
  initState() {
    super.initState();
    data = new List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CBNU IMAGE COLLECTOR'),
      ),
      body: Container(
          child: Center(
              child: data!.isEmpty
                  ? const Text(
                      'No Data',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: Card(
                          child: Container(
                            child: Row(children: <Widget>[
                              Image.network(
                                data![index]['image_url'],
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              Text(data![index]['collection'].toString()),
                              Text(data![index]['display_sitename'].toString()),
                            ]),
                          ),
                        ));
                      },
                      itemCount: data!.length,
                    ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getJSONData();
        },
        child: const Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJSONData() async {
    var url = 'https://dapi.kakao.com/v2/search/image?target=title&query=충북대';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK <your REST api key>"});

    print(response.body);
    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);
    });
    return response.body;
  }
}
