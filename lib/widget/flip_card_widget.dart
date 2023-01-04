import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FlipCardWidget extends StatefulWidget {
  final String url;
  final String diary;

  const FlipCardWidget({Key? key, required this.url, required this.diary})
      : super(key: key);

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  bool isFront = true;

  @override
  void initState() {
    Logger().d('initState');
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
          setState(() {
            isFront = !isFront;
          });
        },
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isFront ? frontCard(widget.url) : backCard(widget.diary)),
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
