import 'dart:developer';

import 'package:today/config/di/di.dart';
import 'package:today/data/models/diary_dto.dart';
import 'package:today/domain/diary_content.dart';
import 'package:today/data/models/network_response.dart';
import 'package:today/data/repository/diary_repository.dart';

class DiaryUseCase {
  late DiaryRepository _diaryRepository;

  DiaryUseCase() {
    _diaryRepository = getIt.get<DiaryRepository>();
  }

  Future<Result> saveImageAndText(
      DateTime date, String text, String imagePath) async {
    try {
      await _diaryRepository.saveImageAndText(date, text, imagePath);
      return Result.success(data: true);
    } catch (e) {
      return Result.failure(data: false);
    }
  }

  Future<Result> getImages(DateTime date) async {
    try {
      List<DiaryContent> contentList = [];
      List<DiaryDto> result = await _diaryRepository.getImages(date);
      if (result.isNotEmpty) {
        contentList = result
            .map((e) {
              return DiaryContent(
                imageUrl: e.imageUrl,
                content: e.content,
              );
            })
            .cast<DiaryContent>()
            .toList();
      }
      return Result.success(data: contentList);
    } catch (e) {
      log('error : $e');
      return Result.failure(data: List.empty());
    }
  }
}
