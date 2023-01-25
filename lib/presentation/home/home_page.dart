import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:today/data/models/diary.dart';
import 'package:today/presentation/home/home_viewmodel.dart';
import 'package:today/widget/flip_card_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageStorageKey mainKey = const PageStorageKey<String>('mainKey');
  PageStorageKey childKey = const PageStorageKey<String>('childKey');

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

    Logger().d('onBuild in _HomePageState');
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Text(
            'Photo Diary',
            style: GoogleFonts.getFont(
              'Nanum Gothic',
              fontSize: 28.0,
            ),
          ),
          onTap: () {},
        ),
        centerTitle: true,
        backgroundColor: Colors.white30,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                return viewModel.diaryList.isEmpty
                    ? emptyView()
                    : diaryList(viewModel.diaryList);
              },
            ),
            Visibility(
              visible: isLoading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeViewModel>().updateDiaryList();
        },
      ),
    );
  }

  Widget emptyView() {
    return const Center(
      child: Text('일기를 채워주세요'),
    );
  }

  Widget diaryList(List<Diary> list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Diary data = list[index];
          return Column(
            children: [
              ListTile(
                title: Text(data.getDateTime()),
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
                    return getDetailList(item);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget getDetailList(DiaryItem item) {
    return FlipCardWidget(
      key: UniqueKey(),
      item: item,
    );
  }
}
