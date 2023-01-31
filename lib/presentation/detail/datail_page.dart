import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/presentation/home/widget/flip_card_widget.dart';

class DetailPage extends StatelessWidget {
  final DiaryItem item;
  final UniqueKey uniqueKey;

  const DetailPage({Key? key, required this.item, required this.uniqueKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCardWidget(
      uniqueKey: uniqueKey,
      item: item,
    );
  }
}
