import 'package:today/data/models/diary.dart';

abstract class DiaryRepository {
  Future<void> saveImageAndText(String text, String imagePath);
  Future<List<DiaryItem>> getImages();
}
