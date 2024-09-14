import 'package:flutify/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Pallete.errorColor,
        body: Center(
          child: Text('SOME Error has occured'),
        ));
  }
}
