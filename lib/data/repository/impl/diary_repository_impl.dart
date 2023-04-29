import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:today/data/models/diary_dto.dart';
import 'package:today/data/repository/diary_repository.dart';
import 'package:path/path.dart' as path;

class DiaryRepositoryImpl implements DiaryRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<DiaryDto>> getImages(DateTime date) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return [];
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('diaries')
          .doc('${date.year}-${date.month}-${date.day}')
          .collection('diary')
          .get();

      if (querySnapshot.docs.isEmpty) {
        return List<DiaryDto>.empty();
      } else {
        return querySnapshot.docs.map((e) {
          String imageUrl = e.get('image_url');
          String content = e.get('content');
          log('imageUrl : $imageUrl // content: $content');
          return DiaryDto(
            imageUrl: imageUrl,
            content: content,
          );
        }).toList();
      }
    } catch (e) {
      log('getImages failed: $e');
      rethrow;
    }
  }

  @override
  Future<void> saveImageAndText(
      DateTime date, String content, String imagePath) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(message: 'User not logged in', code: "0");
      }

      String fileName = '${date.toIso8601String()}.jpg';

      Directory cacheDir = await getTemporaryDirectory();
      File tempImageFile = File(path.join(cacheDir.path, fileName));
      await tempImageFile.writeAsBytes(await File(imagePath).readAsBytes());

      Reference ref = _storage.ref().child(user.uid).child(fileName);
      UploadTask uploadTask = ref.putFile(tempImageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('diaries')
          .doc('${date.year}-${date.month}-${date.day}')
          .collection('diary')
          .add(
        {
          'content': content,
          'image_url': imageUrl,
          'date': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
