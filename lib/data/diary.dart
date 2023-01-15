import 'package:flutter/cupertino.dart';

class Diary {
  final DateTime date;
  final List<DiaryItem> itemList;

  Diary({required this.date, required this.itemList});
}

class DiaryItem {
  final String imageUrl;
  final String diary;
  bool isFront = true;

  DiaryItem({required this.imageUrl, required this.diary});

  void onReverse() {
    isFront = !isFront;
  }
}

var dummyList = [
  Diary(date: DateTime.parse('20230115'), itemList: [
    DiaryItem(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        diary: 'TEST1'),
    DiaryItem(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        diary: 'TEST2'),
    DiaryItem(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        diary: 'TEST3'),
    DiaryItem(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        diary: 'TEST4'),
    DiaryItem(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        diary: 'TEST5'),
  ])
];
