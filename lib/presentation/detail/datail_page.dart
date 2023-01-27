import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final String imgUrl;
  final int index;

  const DetailPage({Key? key, required this.index, required this.imgUrl})
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
          Hero(
            tag: '$imgUrl$index',
            child: Image.network(
              imgUrl,
            ),
          )
        ],
      ),
    );
  }
}
