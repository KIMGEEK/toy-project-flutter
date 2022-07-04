import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:memo_app/memo.dart';

class MemoDetailPage extends StatefulWidget {
  final DatabaseReference reference;
  final Memo memo;

  MemoDetailPage(this.reference, this.memo);
  @override
  State<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  TextEditingController? titleController;
  TextEditingController? contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.memo.title);
    contentController = TextEditingController(text: widget.memo.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo.title),
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
                  decoration: InputDecoration(labelText: 'content'),
                )),
                MaterialButton(
                  onPressed: () {
                    Memo memo = Memo(titleController!.value.text,
                        contentController!.value.text, widget.memo.createdTime);
                    widget.reference
                        .child(widget.memo.key!)
                        .set(memo.toJson())
                        .then((_) {
                      Navigator.of(context).pop(memo);
                    });
                  },
                  child: Text('Update'),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1)),
                )
              ],
            ),
          )),
    );
  }
}
