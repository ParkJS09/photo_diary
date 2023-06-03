import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:today/domain/models/diary_content.dart';
import 'package:today/presentation/add/add_diary_page.dart';
import 'package:today/presentation/detail/datail_page.dart';
import 'package:today/presentation/home/home_state.dart';
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
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Photo Diary',
          style: Theme.of(context).textTheme.titleMedium,
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
                  HomeDiaryState homeState = viewModel.homeState;
                  if (homeState is DiaryPreparing) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (homeState is DiaryList) {
                    if (homeState.diaryItem.isEmpty) {
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
                      children: homeState.diaryItem
                          .map((diary) => _buildDiaryImage(diary))
                          .toList(),
                    );
                  } else {
                    return emptyView();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddDiaryPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
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
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Hero(
          tag: key,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
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
        ),
      ),
    );
  }

  Widget emptyView() {
    return const Center(
      child: Text('일기를 채워주세요'),
    );
  }
}
