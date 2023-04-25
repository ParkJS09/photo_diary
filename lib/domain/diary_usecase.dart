import 'package:today/config/di/di.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/data/models/network_response.dart';
import 'package:today/data/repository/diary_repository.dart';

class DiaryUseCase {
  late DiaryRepository _diaryRepository;

  DiaryUseCase() {
    _diaryRepository = getIt.get<DiaryRepository>();
  }

  Future<Result> saveImageAndText(String text, String imagePath) async {
    try {
      await _diaryRepository.saveImageAndText(text, imagePath);
      return Result.success(data: NetworkSuccess(data: true));
    } catch (e) {
      return Result.failure(data: NetworkFail(data: false));
    }
  }

  Future<List<DiaryItem>> getImages() async {
    return List.empty();
  }
}
