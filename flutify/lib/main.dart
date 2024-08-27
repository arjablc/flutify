import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import "./core/router/router.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkAppTheme,
      routerConfig: RouteService.routerConfig,
    );
  }
}
