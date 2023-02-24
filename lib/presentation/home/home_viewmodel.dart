import 'package:flutter/material.dart';
import 'package:today/config/di/di.dart';
import 'package:today/data/models/diary.dart';
import 'package:intl/intl.dart';
import 'package:today/domain/diary_usecase.dart';

class HomeViewModel extends ChangeNotifier {
  DateTime selectDate = DateTime.now();
  List<Diary> diaryList = List.empty();
  bool isLoading = false;

  late DiaryUseCase _diaryUseCase;

  HomeViewModel() {
    _diaryUseCase = getIt.get<DiaryUseCase>();
  }

  void setDatetime(DateTime dateTime) {
    if (selectDate != dateTime) {
      selectDate = dateTime;
      notifyListeners();
      getDiaryList();
    }
  }

  String getDateTime() {
    return DateFormat('yyyy년 MM월 dd일').format(selectDate);
  }

  Future<void> getDiaryList() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 3000), () {
      isLoading = false;
      diaryList = List.empty();
      notifyListeners();
    });
  }

  Future<void> updateDiaryList() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 3000), () {
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> uploadDiary(String text, String path) async {
    await _diaryUseCase.saveImageAndText(text, path);
  }

  void onReverse(DiaryItem item) {
    item.onReverse();
    notifyListeners();
  }
}
