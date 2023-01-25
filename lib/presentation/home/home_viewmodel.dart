import 'package:flutter/material.dart';
import 'package:today/data/models/diary.dart';

class HomeViewModel extends ChangeNotifier {

  List<Diary> diaryList = List.empty();
  bool isLoading = false;

  Future<void> getDiaryList() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 3000), () {
      isLoading = false;
      diaryList = dummyList;
      notifyListeners();
    });
  }

  Future<void> updateDiaryList() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 3000), () {
      diaryList.add(
        Diary(
          date: DateTime.now(),
          itemList: [
            DiaryItem(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
                diary: 'TEST1'),
          ],
        ),
      );
      isLoading = false;
      notifyListeners();
    });
  }

  void onReverse(DiaryItem item) {
    item.onReverse();
    notifyListeners();
  }
}
