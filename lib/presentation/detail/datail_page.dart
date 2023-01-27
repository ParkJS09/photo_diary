import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:today/data/models/diary.dart';

class DetailPage extends StatelessWidget {
  final DiaryItem item;
  final UniqueKey uniqueKey;

  const DetailPage({Key? key,required this.item, required this.uniqueKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DetailPage',
          style: GoogleFonts.getFont('Nanum Gothic',
              fontSize: 28.0, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white30,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Hero(
                tag: uniqueKey,
                child: Image.network(
                  item.imageUrl,
                )
            ),
          )
        ],
      ),
    );
  }
}
