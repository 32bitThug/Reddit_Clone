import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// ignore_for_file: <lint-rules>
void showSnackBar(BuildContext context, String t) {
  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showSnackBar(
      SnackBar(
        content: Text(t),
      ),
    );
}

Future<FilePickerResult?> pickImg()  async{
  final image = await FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}
