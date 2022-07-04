import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:memo_app/memo.dart';

class MemoAddPage extends StatefulWidget {
  final DatabaseReference reference;

  MemoAddPage(this.reference);
  @override
  State<MemoAddPage> createState() => _MemoAddPageState();
}

class _MemoAddPageState extends State<MemoAddPage> {
  TextEditingController? titleController;
  TextEditingController? contentController;

  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Memo'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Title', fillColor: Colors.blueAccent),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 100,
                  decoration: InputDecoration(labelText: 'Content'),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  widget.reference
                      .push()
                      .set(Memo(
                              titleController!.value.text,
                              contentController!.value.text,
                              DateTime.now().toIso8601String())
                          .toJson())
                      .then((_) {
                    Navigator.of(context).pop();
                  });
                },
                child: Text('Save'),
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
