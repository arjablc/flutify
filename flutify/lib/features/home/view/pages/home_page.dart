import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Pallete.gradient1, body: Center(child: Text('Home page')));
  }
}
