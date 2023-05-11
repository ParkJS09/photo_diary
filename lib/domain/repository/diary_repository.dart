import 'package:today/data/models/diary_dto.dart';

abstract class DiaryRepository {
  Future<void> saveImageAndText(DateTime date, String text, String imagePath);

  Future<List<DiaryDto>> getImages(DateTime date);
}
