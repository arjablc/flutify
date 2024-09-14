import 'package:flutify/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: 100,
      child: CircularProgressIndicator.adaptive(
        backgroundColor: Pallete.gradient2,
        strokeWidth: 10,
      ),
    );
  }
}
