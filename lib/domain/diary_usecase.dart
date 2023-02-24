import 'package:today/config/di/di.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/data/repository/diary_repository.dart';

class DiaryUseCase {
  late DiaryRepository _diaryRepository;

  DiaryUseCase() {
    _diaryRepository = getIt.get<DiaryRepository>();
  }

  @override
  Future<void> saveImageAndText(String text, String imagePath) async {
    await _diaryRepository.saveImageAndText(text, imagePath);
  }

  @override
  Future<List<DiaryItem>> getImages() async {
    return List.empty();
  }
}
