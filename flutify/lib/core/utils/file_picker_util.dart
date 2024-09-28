import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';

Future<File?> pickFile(FileType fileType) async {
  try {
    final pickedFile = await FilePicker.platform.pickFiles(type: fileType);
    if (pickedFile != null) {
      return File(pickedFile.files.first.xFile.path);
    }
    return null;
  } catch (error) {
    debugPrint(error.toString());
    return null;
  }
}
