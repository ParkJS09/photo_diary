import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:today/presentation/home/home_state.dart';
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
    late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
    late final TextTheme _textTheme = Theme.of(context).textTheme;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Consumer<HomeViewModel>(
      builder: (_, viewModel, child) {
        HomeDiaryState homeState = viewModel.homeState;
        if (homeState is Finish) {
          Navigator.pop(context);
        }
        return Scaffold(
          backgroundColor: _colorScheme.background,
          appBar: AppBar(
            leading: const BackButton(color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              '일기 추가하기',
              style: _textTheme.titleMedium,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 14.0,
                        ),
                        child: Text(
                          "사진 추가하기",
                          textAlign: TextAlign.start,
                          style: _textTheme.titleSmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _getImageFromGallery();
                          },
                          child: Container(
                            width: deviceWidth,
                            height: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _colorScheme.onPrimaryContainer,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                              color: _colorScheme.primaryContainer,
                            ),
                            child: imageField(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 14.0),
                        child: TextField(
                          controller: _textController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          maxLength: 100,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: _colorScheme.primary,
                              ),
                            ),
                            labelText: '오늘 하루는?',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(
                    deviceWidth,
                    70,
                  ),
                  backgroundColor: _colorScheme.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.zero,
                    ),
                  ),
                ),
                child: Text(
                  "오늘의 발자국",
                  style: _textTheme.bodyMedium
                          ?.copyWith(color: _colorScheme.background) ??
                      const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white24,
                      ),
                ),
                onPressed: () {
                  viewModel.uploadDiary(_textController.text, _image!.path);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget imageField() {
    if (_image == null) {
      // TODO Change Default Image
      return Image.asset('assets/images/gnar.jpeg');
    }
    return Image.file(File(_image!.path));
  }
}
