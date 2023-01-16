import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/services/diary_service.dart';
import 'package:today/widget/flip_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageStorageKey mainKey = PageStorageKey<String>('mainKey');
  PageStorageKey childKey = PageStorageKey<String>('childKey');

  var list = dummyList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photo Diary',
          style: GoogleFonts.getFont(
            'Nanum Gothic',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white30,
      ),
      body: list.isEmpty
          ? Center(
              child: Text('일기를 채워주세요'),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  key: UniqueKey(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    Logger().d('main itemBuilder : $index');
                    Diary data = list[index];
                    return Column(
                      children: [
                        ListTile(
                          //TODO date Format yyyyMMdd
                          title: Text(data.date.toString()),
                        ),
                        Container(
                          height: 320,
                          decoration: const BoxDecoration(),
                          child: ListView.builder(
                            key: UniqueKey(),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.itemList.length,
                            itemBuilder: (_, childIndex) {
                              DiaryItem item = data.itemList[childIndex];
                              Logger().d('child itemBuilder : $index');
                              return getDetailList(item);
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }

  Widget getDetailList(DiaryItem item) {
    return Consumer<DiaryService>(
      builder: (context, diaryService, _) {
        return FlipCardWidget(
          key: UniqueKey(),
          item: item,
        );
      },
    );
  }
}
