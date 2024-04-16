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
