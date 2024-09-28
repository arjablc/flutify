import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutify/core/utils/file_picker_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/custom_field.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final TextEditingController _artistNameController = TextEditingController();
  final TextEditingController _songNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;

  void colorChange(Color pickedColor) {
    setState(() {
      selectedColor = pickedColor;
    });
  }

  void selectImage() async {
    final pickedImage = await pickFile(FileType.image);
    setState(() {
      selectedImage = pickedImage;
    });
  }

  void selectAudio() async {
    final pickedAudio = await pickFile(FileType.audio);
    setState(() {
      selectedAudio = pickedAudio;
    });
  }

  Color pickedColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload song'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(children: [
            GestureDetector(
              onTap: selectImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallete.greyColor,
                      width: 3,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(selectedImage!, fit: BoxFit.cover))
                    : const Icon(
                        Icons.upload_file,
                        color: Pallete.whiteColor,
                        size: 40,
                      ),
              ),
            ),
            const SizedBox(height: 10),
            CustomField(
              hintText: 'Artist Name',
              isObscured: false,
              controller: _artistNameController,
            ),
            const SizedBox(height: 10),
            CustomField(
                hintText: 'Song Name',
                isObscured: false,
                controller: _songNameController),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                side: const BorderSide(color: Pallete.gradient1, width: 2),
              ),
              onPressed: selectAudio,
              child: Text('Choose Song',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.normal)),
            ),
            ColorPicker(
              pickersEnabled: const {
                ColorPickerType.wheel: true,
                ColorPickerType.primary: true,
                ColorPickerType.accent: false
              },
              selectedPickerTypeColor: Pallete.backgroundColor,
              pickerTypeTextStyle: Theme.of(context).textTheme.titleSmall,
              onColorChanged: colorChange,
            )
          ]),
        ),
      ),
    );
  }
}
