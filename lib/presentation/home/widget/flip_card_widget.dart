import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/presentation/home/home_viewmodel.dart';

class FlipCardWidget extends StatefulWidget {
  DiaryItem item;
  Key uniqueKey;
  FlipCardWidget({Key? key, required this.uniqueKey, required this.item}) : super(key: key);

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  late HomeViewModel homeViewModel;
  bool _isFront = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(
        onTap: () {
          log('onTap');
          setState(() {
            _isFront = !_isFront;
          });
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isFront
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
      child: Hero(
        tag: widget.uniqueKey,
        child: Image.network(
          widget.item.imageUrl,
          fit:  BoxFit.contain,
        ),
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
          widget.item.diary,
          style: GoogleFonts.getFont(
            'Nanum Gothic',
            fontSize: 28.0,
            color: Colors.black
          ),
        ),
      ),
    );
  }
}
