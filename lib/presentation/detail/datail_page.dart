import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:today/domain/diary_content.dart';
import 'package:today/presentation/home/widget/flip_card_widget.dart';

class DetailPage extends StatelessWidget {
  final DiaryContent item;
  final UniqueKey uniqueKey;
  final UniqueKey containerKey;

  const DetailPage(
      {Key? key,
      required this.item,
      required this.containerKey,
      required this.uniqueKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlipCardWidget(
          uniqueKey: uniqueKey,
          item: item,
        )
      ],
    );
  }
}
