import 'package:today/data/models/diary_dto.dart';
import 'package:today/domain/diary_content.dart';
import 'package:today/data/models/network_response.dart';

abstract class DiaryRepository {
  Future<void> saveImageAndText(DateTime date, String text, String imagePath);
  Future<List<DiaryDto>> getImages(DateTime date);
}
