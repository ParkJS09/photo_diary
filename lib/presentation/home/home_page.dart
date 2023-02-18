import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/presentation/add/add_diary_page.dart';
import 'package:today/presentation/detail/datail_page.dart';
import 'package:today/presentation/home/home_viewmodel.dart';
import 'package:today/presentation/home/widget/main_calendar.dart';
import 'package:today/utils/hero_dialog_router.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageStorageKey mainKey = const PageStorageKey<String>('mainKey');
  PageStorageKey childKey = const PageStorageKey<String>('childKey');
  ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().getDiaryList();
  }

  @override
  Widget build(BuildContext context) {
    context.select((HomeViewModel homeViewModel) => homeViewModel.isLoading);
    final isLoading = context.select<HomeViewModel, bool>(
        (HomeViewModel viewModel) => viewModel.isLoading);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photo Diary',
          style: GoogleFonts.getFont('Nanum Gothic',
              fontSize: 28.0, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white30,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const MainCalendar(),
            Expanded(
              child: Consumer<HomeViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (viewModel.diaryList.isEmpty) {
                    return emptyView();
                  }
                  return GridView.count(
                    padding: const EdgeInsets.symmetric(
                      vertical: 28.0,
                      horizontal: 14.0,
                    ),
                    crossAxisCount: 3,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                    children: List.generate(
                      viewModel.diaryList.length,
                      (index) {
                        DiaryItem item = viewModel.diaryList[0].itemList[0];
                        UniqueKey containerKey = UniqueKey();
                        UniqueKey key = UniqueKey();
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              HeroDialogRoute(
                                builder: (BuildContext context) => DetailPage(
                                  containerKey: containerKey,
                                  uniqueKey: key,
                                  item: item,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Hero(
                                tag: containerKey,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                              Hero(
                                tag: key,
                                child: Image.network(
                                  item.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddDiaryPage(),
            ),
          );
        },
      ),
    );
  }

  Widget emptyView() {
    return const Center(
      child: Text('일기를 채워주세요'),
    );
  }
}
