import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:today/presentation/home/home_page.dart';
import 'package:today/presentation/sign/auth_page.dart';
import 'package:today/presentation/sign/auth_state.dart';
import 'package:today/presentation/sign/auth_viewmodel.dart';

final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => AuthPage(),
      ),
    ],
    redirect: (context, state) {
      AuthState authState = context.watch<AuthViewModel>().authState;
      return authState is AuthenticatedState ? '/' : '/login';
    }
);
