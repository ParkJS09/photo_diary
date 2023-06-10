import 'package:today/domain/models/diary_content.dart';

sealed class HomeDiaryState {}

class DiaryPreparing implements HomeDiaryState {
  final bool _isLoading;

  DiaryPreparing(this._isLoading);

  bool get isLoading => _isLoading;
}

class DiaryList implements HomeDiaryState {
  final List<DiaryContent> _diaryList;

  DiaryList(this._diaryList);

  List<DiaryContent> get diaryItem => _diaryList;
}


class Finish implements HomeDiaryState {}
