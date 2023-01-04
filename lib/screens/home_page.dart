import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:today/data/diary.dart';
import 'package:today/widget/flip_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageStorageKey mainKey = PageStorageKey<String>('mainKey');
  PageStorageKey childKey = PageStorageKey<String>('childKey');

  var list = [
    Diary(
        'test',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        'test',
        DateTime(2022, 12, 28)),
    Diary(
        'test',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        'test',
        DateTime(2022, 12, 27)),
    Diary(
        'test',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        'test',
        DateTime(2022, 12, 17)),
    Diary(
        'test',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        'test',
        DateTime(2022, 12, 16)),
    Diary(
        'test',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        'test',
        DateTime(2022, 12, 15)),
    Diary(
        'test',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0G4Jj47yiz5zOPtf3AAha0jxUcoX4SAo_Gw&usqp=CAU',
        'test',
        DateTime(2022, 12, 14)),
  ];

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
                            itemCount: 10,
                            itemBuilder: (_, childIndex) {
                              Logger().d('child itemBuilder : $index');
                              return getDetailList(childIndex);
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

  Widget getDetailList(int index) {
    return FlipCardWidget(
      key: UniqueKey(),
      url: 'https://picsum.photos/200/300',
      diary: index.toString(),
    );
  }
}
