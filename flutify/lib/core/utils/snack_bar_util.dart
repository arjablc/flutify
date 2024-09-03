import 'package:flutter/material.dart';

import '../failure/failure.dart';
import '../theme/app_pallete.dart';

void showErrorSnackbar(
    {required ServerFailure failure, required BuildContext context}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(failure.message),
            ...?failure.details?.map((e) => Text(e.toString()))
          ]),
      backgroundColor: Pallete.errorColor,
    ));
}

void showInfoSnackbar(
    {required String infoMessage, required BuildContext context}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
        backgroundColor: Pallete.gradient3, content: Text(infoMessage)));
}