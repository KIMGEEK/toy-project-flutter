import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Memo {
  String? key;
  String title;
  String content;
  String createdTime;

  Memo(this.title, this.content, this.createdTime);

  Memo.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value['title'],
        content = snapshot.value['content'],
        createdTime = snapshot.value['createdTime'];

  toJson() {
    return {
      'title': title,
      'content': content,
      'createdTime': createdTime,
    };
  }
}
