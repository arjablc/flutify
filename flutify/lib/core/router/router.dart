import 'package:flutify/core/pages/error_page.dart';
import 'package:flutify/core/service/auth_state_service.dart';
import 'package:flutify/features/auth/view/pages/about_me_page.dart';
import 'package:flutify/features/auth/view/pages/login_page.dart';
import 'package:flutify/features/home/view/pages/home_page.dart';
import 'package:flutify/features/home/view/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/view/pages/signup_page.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final currentUser = ref.watch(authStateServiceProvider);
  GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/home/upload-song',
    errorBuilder: (context, state) => const ErrorPage(),
    redirect: (context, state) {
      //TODO: uncomment
      //if (currentUser == null) {
      //  if (!AuthRoutes.unAuthorized.allowed.contains(state.fullPath)) {
      //    debugPrint('from unauthorized redirect');
      //    return AuthRoutes.unAuthorized.redirect;
      //  }
      //} else {
      //  if (!AuthRoutes.authrized.allowed.contains(state.fullPath)) {
      //    debugPrint('from authorized redirect');
      //    return AuthRoutes.authrized.redirect;
      //  }
      //}
      //return null;
    },
    routes: [
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: 'about-me',
              builder: (context, state) => const AboutMePage(),
            ),
            GoRoute(
              path: 'upload-song',
              builder: (context, state) => const UploadSongPage(),
            )
          ])
    ],
  );
  return router;
}

enum AuthRoutes {
  unAuthorized(redirect: '/login', allowed: ['/login', '/signup']),
  authrized(redirect: '/home', allowed: ['/about-me', '/home']);

  const AuthRoutes({required this.redirect, required this.allowed});

  final String redirect;
  final List<String> allowed;
}
