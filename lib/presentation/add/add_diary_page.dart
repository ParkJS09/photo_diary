import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:today/presentation/home/home_viewmodel.dart';

class AddDiaryPage extends StatefulWidget {
  const AddDiaryPage({Key? key}) : super(key: key);

  @override
  State<AddDiaryPage> createState() => _AddDiaryPageState();
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  XFile? _image;
  late ImagePicker _imagePicker;

  void _getImageFromGallery() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = image;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일기 추가하기'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TODO 일기 추가하기
            Text(context.read<HomeViewModel>().getDateTime()),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: imageField(),
            ),
            TextField(),
            // Add your button here
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity, // make button full width
                child: ElevatedButton(
                  onPressed: () {
                    // handle button press
                  },
                  child: Text('My Button'),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getImageFromGallery();
        },
      ),
    );
  }

  Widget imageField() {
    if (_image == null) {
      return Image.asset('assets/images/gnar.jpeg');
    }
    return Image.file(File(_image!.path));
  }
}
