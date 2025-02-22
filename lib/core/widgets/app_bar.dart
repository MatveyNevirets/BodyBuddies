import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/material.dart';

AppBar createAppBarWidget({required String appbarTitle}) {
  return AppBar(
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      const SizedBox(
        width: 10,
      ),
    ],
    title: Text(
      appbarTitle,
      style: Styles.appbar_text_style,
    ),
  );
}
