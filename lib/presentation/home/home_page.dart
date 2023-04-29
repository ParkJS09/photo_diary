import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:today/domain/diary_content.dart';
import 'package:today/presentation/add/add_diary_page.dart';
import 'package:today/presentation/detail/datail_page.dart';
import 'package:today/presentation/home/home_viewmodel.dart';
import 'package:today/presentation/home/widget/main_calendar.dart';
import 'package:today/utils/hero_dialog_router.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _listScrollController;

  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().getDiaryList();
    _listScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photo Diary',
          style: GoogleFonts.notoSans(
            fontSize: 28.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const MainCalendar(),
            Expanded(
              child: Consumer<HomeViewModel>(
                builder: (context, viewModel, _) {
                  log('viewModel.isLoading: ${viewModel.isLoading}');
                  log('viewModel.diaryList: ${viewModel.diaryList}');
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
                    controller: _listScrollController,
                    children: viewModel.diaryList
                        .map((diary) => _buildDiaryImage(diary))
                        .toList(),
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
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDiaryImage(DiaryContent diary) {
    final containerKey = UniqueKey();
    final key = UniqueKey();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          HeroDialogRoute(
            builder: (BuildContext context) => DetailPage(
              containerKey: containerKey,
              uniqueKey: key,
              item: diary,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: containerKey,
            child: SizedBox(
              width: 150,
              height: 150,
            ),
          ),
          Hero(
            tag: key,
            child: diary.imageUrl != null
                ? Image.network(
                    diary.imageUrl!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/gnar.jpeg',
                    fit: BoxFit.contain,
                  ),
          ),
        ],
      ),
    );
  }

  Widget emptyView() {
    return const Center(
      child: Text('일기를 채워주세요'),
    );
  }
}
