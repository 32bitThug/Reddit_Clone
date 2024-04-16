import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error1;
  const ErrorText({super.key, required  this.error1});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error1),
    );
  }
}
