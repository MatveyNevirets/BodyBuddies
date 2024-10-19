import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/icons/flutter-icons-ef864561/bottom_icons_icons.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget
{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentTab = 2;
  List<Widget> screens = [
    Text("Это новостной экран"),
    Text("Тут будут чаты"),
    Text("Тут будет всё тренировочное\nПо совместительству, первый экран"),
    Text("Тут будет твой профиль"),
  ];

  List<String> appbarTitles = [
    "Новости",
    "Чаты",
    "Тренировки",
    "Профиль"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colours.app_bar_color, title: Text(appbarTitles[currentTab], style: Styles.appbar_text_style,),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      elevation: Styles.base_elevation, items: [
        baseBottomNavigationBarItem(BottomIcons.newspaper, ""),
        baseBottomNavigationBarItem(BottomIcons.chat, ""),
        baseBottomNavigationBarItem(BottomIcons.dumbbell, ""),
        baseBottomNavigationBarItem(BottomIcons.user, ""),
      ], onTap: setCurrentTab,),
      body: SafeArea(
        child: Container(margin: Styles.base_magrin_size,
        child: Center(child: screens[currentTab]),),
      ),
    );
  }

  setCurrentTab(int index) {
    if(currentTab == index) return;

    setState(() {
      currentTab = index;
    });
  }
}