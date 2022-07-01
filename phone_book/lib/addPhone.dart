import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:phone_book/phone.dart';

class AddPhone extends StatefulWidget {
  final Future<Database> db;
  AddPhone(this.db);

  @override
  State<AddPhone> createState() => _AddPhoneState();
}

class _AddPhoneState extends State<AddPhone> {
  TextEditingController? nameController;
  TextEditingController? numberController;

  @override
  initState() {
    super.initState();
    nameController = new TextEditingController();
    numberController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Phone'),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Number'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Phone phone = Phone(
                  name: nameController!.value.text,
                  number: numberController!.value.text,
                );
                Navigator.of(context).pop(phone);
              },
              child: Text('Save'),
            ),
          ],
        )),
      ),
    );
  }
}
