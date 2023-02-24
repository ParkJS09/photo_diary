import 'package:intl/intl.dart';

class Diary {
  final DateTime date;
  final List<DiaryItem> itemList;

  Diary({required this.date, required this.itemList});

  String getDateTime() {
    return DateFormat.yMMMd('ko-KR').format(date);
  }
}

class DiaryItem {
  final String date;
  final String imageUrl;
  final String diary;
  bool isFront = true;

  DiaryItem({required this.date, required this.imageUrl, required this.diary});

  void onReverse() {
    isFront = !isFront;
  }
}

var dummyList = [];
