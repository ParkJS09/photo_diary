import 'package:flutter/material.dart';
import 'package:today/config/di/di.dart';
import 'package:today/domain/models/diary_content.dart';
import 'package:today/data/models/network_response.dart';
import 'package:today/domain/diary_usecase.dart';
import 'package:today/presentation/home/home_state.dart';
import 'package:today/utils/calendar_util.dart';

class HomeViewModel extends ChangeNotifier {
  late DiaryUseCase _diaryUseCase;
  late DateTime _selectDate = DateTime.now();
  late HomeDiaryState _homeState = DiaryPreparing(true);

  HomeDiaryState get homeState => _homeState;

  DateTime get selectDate => _selectDate;

  HomeViewModel() {
    _diaryUseCase = getIt.get<DiaryUseCase>();
  }

  void init() {
    _selectDate = DateTime.now();
    _homeState = DiaryPreparing(true);
    notifyListeners();
  }

  void setDatetime(DateTime dateTime) {
    if (_selectDate != dateTime) {
      _selectDate = dateTime;
      getDiaryList();
    }
  }

  //TODO 이 정보는 여기 있을 필요가 없을듯?
  String getSelectDate() {
    return getDateTime(_selectDate);
  }

  Future<void> getDiaryList() async {
    List<DiaryContent> diaryList = [];
    _homeState = DiaryPreparing(true);
    notifyListeners();
    Result _result = await _diaryUseCase.getImages(_selectDate);
    _result.when(
      success: (data) {
        diaryList = data;
        _homeState = DiaryList(diaryList = data);
      },
      failure: (data) {},
      error: (msg) {},
    );
    notifyListeners();
  }

  Future<void> uploadDiary(String text, String path) async {
    // Result _result =
    //     await _diaryUseCase.saveImageAndText(_selectDate, text, path);
    // _result.when(success: (data) {
    //   _homeState = Finish();
    // }, failure: (data) {}, error: (msg) {});
    _homeState = Finish();
    notifyListeners();
  }
}
