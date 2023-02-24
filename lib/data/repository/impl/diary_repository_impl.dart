import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/data/repository/diary_repository.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<DiaryItem>> getImages() async {
    return List.empty();
  }

  @override
  Future<void> saveImageAndText(String text, String imagePath) async {
    // Get the current user
    User? user = _auth.currentUser;

    if (user == null) {
      // handle error
      return;
    }

    // Create a reference to the image file in Firebase Storage
    Reference ref = _storage
        .ref()
        .child(user.uid)
        .child('${DateTime.now().toIso8601String()}.jpg');

    // Upload the image to Firebase Storage
    UploadTask uploadTask = ref.putFile(File(imagePath));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    // Get the URL of the uploaded image
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    // Save the image URL and text to Firebase Firestore
    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('images')
        .doc()
        .set({
      'text': text,
      'image_url': imageUrl,
      'date': DateTime.now().toIso8601String()
    });
  }
}
