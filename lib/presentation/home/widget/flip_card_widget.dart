import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/presentation/home/home_viewmodel.dart';

class FlipCardWidget extends StatefulWidget {
  DiaryItem item;
  Key uniqueKey;

  FlipCardWidget({Key? key, required this.uniqueKey, required this.item})
      : super(key: key);

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  bool _isFront = true;

  void _onReverse() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(
        onTap: _onReverse,
        child: AnimatedSwitcher(
          layoutBuilder: (widget, list) => Center(
            child: Stack(children: [widget!, ...list]),
          ),
          transitionBuilder: _transitionBuilder,
          duration: const Duration(milliseconds: 1000),
          child: _isFront
              ? frontCard(
                  widget.item.imageUrl,
                  const ValueKey(true),
                )
              : backCard(
                  widget.item.diary,
                  const ValueKey(false),
                ),
        ),
      ),
    );
  }

  Widget frontCard(String imageUrl, Key key) {
    return Container(
      key: key,
      width: 320,
      height: 320,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: Colors.grey[200]),
      child: Hero(
        tag: widget.uniqueKey,
        child: Image.network(
          widget.item.imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget backCard(String diary, Key key) {
    return Container(
      key: key,
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
          style: GoogleFonts.getFont('Nanum Gothic',
              fontSize: 28.0, color: Colors.black),
        ),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (_, widget) {
        final isUnder = (ValueKey(_isFront) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
