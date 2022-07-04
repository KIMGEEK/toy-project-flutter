import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:memo_app/memo.dart';
import 'package:memo_app/memoAdd.dart';
import 'package:memo_app/memoDetail.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseURL = 'https://example-70a2f-default-rtdb.firebaseio.com';
  List<Memo> memos = new List.empty(growable: true);

  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('memo');

    reference!.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memo App'),
      ),
      body: Container(
        child: Center(
          child: memos.length == 0
              ? const CircularProgressIndicator()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        header: Text(memos[index].title),
                        footer: Text(memos[index].createdTime),
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: SizedBox(
                            child: GestureDetector(
                              onTap: () async {
                                Memo? memo = await Navigator.of(context).push(
                                    MaterialPageRoute<Memo>(
                                        builder: (BuildContext context) =>
                                            MemoDetailPage(
                                                reference!, memos[index])));
                                if (memo != null) {
                                  setState(() {
                                    memos[index].title = memo.title;
                                    memos[index].content = memo.content;
                                  });
                                }
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(memos[index].title),
                                        content: Text('Delete Memo?'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                reference!
                                                    .child(memos[index].key!)
                                                    .remove()
                                                    .then((_) {
                                                  setState(() {
                                                    memos.removeAt(index);
                                                    Navigator.of(context).pop();
                                                  });
                                                });
                                              },
                                              child: Text('Yes')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No')),
                                        ],
                                      );
                                    });
                              },
                              child: Text(memos[index].content),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: memos.length,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MemoAddPage(reference!)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
