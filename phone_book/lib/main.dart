import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:phone_book/addPhone.dart';
import 'package:phone_book/phone.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(database),
        '/add': (context) => AddPhone(database)
      },
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE phones(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, number TEXT);",
        );
      },
      join(await getDatabasesPath(), 'phone_database.db'),
      version: 1,
    );
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;
  DatabaseApp(this.db);

  @override
  State<DatabaseApp> createState() => _DatabaseAppState();
}

class _DatabaseAppState extends State<DatabaseApp> {
  Future<List<Phone>>? phoneList;

  @override
  void initState() {
    super.initState();
    phoneList = getPhones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Number Book')),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Phone phone = (snapshot.data as List<Phone>)[index];
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Text(phone.name!),
                              Text(phone.number!),
                            ],
                          ),
                        );
                      },
                      itemCount: (snapshot.data as List<Phone>).length,
                    );
                  } else {
                    return Text('No data');
                  }
              }
            },
            future: phoneList,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final phone = await Navigator.of(context).pushNamed('/add');
          if (phone != null) {
            _insertPhone(phone as Phone);
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _insertPhone(Phone phone) async {
    final Database database = await widget.db;

    await database.insert('phones', phone.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      phoneList = getPhones();
    });
  }

  Future<List<Phone>> getPhones() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('phones');

    return List.generate(maps.length, (i) {
      return Phone(
        name: maps[i]['name'].toString(),
        number: maps[i]['number'].toString(),
        id: maps[i]['id'],
      );
    });
  }
}
