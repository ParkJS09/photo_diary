import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/services/diary_service.dart';

class FlipCardWidget extends StatefulWidget {
  DiaryItem item;

  FlipCardWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {

  late DiaryService diaryService;

  @override
  void initState() {
    Logger().d('initState');
    diaryService = context.read<DiaryService>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Logger().d('dispose');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(
        onTap: () {
          diaryService.onReverse(widget.item);
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: widget.item.isFront
              ? frontCard(widget.item.imageUrl)
              : backCard(
                  widget.item.diary,
                ),
        ),
      ),
    );
  }

  Widget frontCard(String imageUrl) {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: Colors.grey[200]),
      child: Image.network(
        imageUrl,
      ),
    );
  }

  Widget backCard(String diary) {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8.0,
          ),
        ),
        color: Colors.grey[200],
      ),
      child: GridPaper(
        color: Colors.blueAccent,
        divisions: 2,
        interval: 300,
        subdivisions: 10,
        child: Text(
          diary,
        ),
      ),
    );
  }
}
