import 'package:body_buddies/features/chats/presentation/widgets/chats_navigator.dart';
import 'package:body_buddies/features/news/presentation/widgets/news_navigator.dart';
import 'package:flutter/material.dart';

import '../../../../core/strings/strings.dart';
import '../../../../core/styles/styles.dart';
import '../../../workouts/presentation/widgets/workouts_screen.dart';

class BodyHomeData {
  int currentTab = 2;

  List<Widget> screens = [
    NewsNavigator(),
   ChatsNavigator(),
    const WorkoutsScreen(),
    const Text("Тут будет твой профиль"),
  ];

  List<String> appbarTitles = [
    Strings.news_appbar_string,
    Strings.chats_appbar_string,
    Strings.workouts_appbar,
    Strings.profile_string
  ];

  AppBar createAppBarWidget() {
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
        appbarTitles[currentTab],
        style: Styles.appbar_text_style,
      ),
    );
  }
}
