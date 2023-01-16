import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:today/data/models/diary.dart';

class DiaryService extends ChangeNotifier {
  var diaryList = dummyList;
  void onReverse(DiaryItem item) {
    item.onReverse();
    notifyListeners();
  }
}