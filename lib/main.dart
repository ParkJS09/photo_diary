import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:today/common/color_schemes.dart';
import 'package:today/config/di/di.dart';
import 'package:provider/provider.dart';
import 'package:today/presentation/home/home_page.dart';
import 'package:today/presentation/home/home_viewmodel.dart';
import 'package:today/presentation/sign/auth_page.dart';
import 'package:today/presentation/sign/auth_viewmodel.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDi();
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return MaterialApp(
          title: 'Photo Diary',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          // TODO 230603 Splash에서 해당 로직 체크
          home: authViewModel.user == null ? const AuthPage() : HomePage(),
        );
      },
    );
  }
}
