import 'dart:developer';
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
  final TextEditingController _textController = TextEditingController();

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
    context.read<HomeViewModel>().init();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (_, viewModel, child) {
        if (viewModel.isSuccess) {
          Navigator.pop(context);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('일기 추가하기'),
            actions: [
              IconButton(
                onPressed: () {
                  viewModel.uploadDiary(_textController.text, _image!.path);
                },
                icon: const Icon(
                  Icons.save,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 14.0),
                  child: Text(
                    context.read<HomeViewModel>().getDateTime(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _getImageFromGallery();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: imageField(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 14.0,
                  ),
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    maxLength: 100,
                    textInputAction: TextInputAction.newline,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget imageField() {
    if (_image == null) {
      return Image.asset('assets/images/gnar.jpeg');
    }
    return Image.file(File(_image!.path));
  }
}
