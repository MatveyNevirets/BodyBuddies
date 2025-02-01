import 'package:flutter/material.dart';

import '../../../../core/styles/styles.dart';

class BodyHomeData {
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
}

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
