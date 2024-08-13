import 'package:flutify/core/theme/app_theme.dart';
import 'package:flutify/features/auth/view/pages/signup_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkAppTheme,
      home: const SignupPage(),
    );
  }
}
