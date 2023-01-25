import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:today/common/constants.dart';
import 'package:today/config/di/di.dart';

import 'package:provider/provider.dart';
import 'package:today/presentation/home/home_page.dart';
import 'package:today/presentation/home/home_viewmodel.dart';
import 'package:today/presentation/sign/auth_page.dart';
import 'package:today/presentation/sign/auth_viewmodel.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  setupDi();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initializeDateFormatting();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
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
          home: authViewModel.user == null ? AuthPage() : HomePage(),
        );
      },
    );
  }
}
