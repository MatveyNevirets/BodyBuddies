import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String snackBarMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(snackBarMessage),
    duration: const Duration(milliseconds: 1500),
  ));
}
