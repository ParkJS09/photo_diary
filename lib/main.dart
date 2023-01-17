import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:today/common/constants.dart';
import 'package:today/config/di/di.dart';
import 'package:today/data/repository/impl/auth_repository_impl.dart';
import 'package:today/domain/auth_usecase.dart';
import 'package:today/presentation/screens/home/home_page.dart';
import 'package:today/presentation/screens/sign/auth_viewmodel.dart';
import 'package:today/presentation/screens/sign/sign_page.dart';
import 'package:provider/provider.dart';
import 'package:today/services/diary_service.dart';
import 'firebase_options.dart';

void main() async {
  setupDi();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DiaryService()),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        log("MainPage // authViewModel.user : ${authViewModel.user}");
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeData,
          home: authViewModel.user == null ? SignPage() : HomePage(),
        );
      },
    );
  }
}
