import 'package:today/data/models/diary.dart';
import 'package:today/data/models/network_response.dart';

abstract class DiaryRepository {
  Future<void> saveImageAndText(String text, String imagePath);
  Future<List<DiaryItem>> getImages();
}
