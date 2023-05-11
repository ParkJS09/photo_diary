import 'package:flutter/material.dart';
import 'package:today/config/di/di.dart';
import 'package:today/domain/models/diary_content.dart';
import 'package:intl/intl.dart';
import 'package:today/data/models/network_response.dart';
import 'package:today/domain/diary_usecase.dart';

class HomeViewModel extends ChangeNotifier {
  DateTime selectDate = DateTime.now();
  List<DiaryContent> diaryList = List.empty();
  bool isLoading = false;
  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  late DiaryUseCase _diaryUseCase;

  HomeViewModel() {
    _diaryUseCase = getIt.get<DiaryUseCase>();
  }

  void init() {
    if (_isSuccess) {
      _isSuccess = false;
      notifyListeners();
    }
  }

  void setDatetime(DateTime dateTime) {
    if (selectDate != dateTime) {
      selectDate = dateTime;
      notifyListeners();
      getDiaryList();
    }
  }

  //TODO 이 정보는 여기 있을 필요가 없을듯?
  String getDateTime() {
    return DateFormat('yyyy년 MM월 dd일').format(selectDate);
  }

  Future<void> getDiaryList() async {
    diaryList = [];
    isLoading = true;
    notifyListeners();
    Result _result = await _diaryUseCase.getImages(selectDate);
    _result.when(
      success: (data) {
        diaryList = data;
      },
      failure: (data) {},
      error: (msg) {},
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> uploadDiary(String text, String path) async {
    Result _result =
        await _diaryUseCase.saveImageAndText(selectDate, text, path);
    _result.when(success: (data) {
      _isSuccess = true;
    }, failure: (data) {
      _isSuccess = false;
    }, error: (msg) {
      _isSuccess = false;
    });
    notifyListeners();
  }
}
