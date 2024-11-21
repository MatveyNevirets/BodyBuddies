import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/assets/icons/flutter-icons-ef864561/bottom_icons_icons.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_bottom_navigation_bar_item.dart';
import 'package:body_buddies/features/home/presentation/widgets/body_home_data.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final data = BodyHomeData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: data.createAppBarWidget(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colours.bottom_bar_icons_color,
        currentIndex: data.currentTab,
        backgroundColor: Colours.bottom_bar_background_color,
        type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        elevation: 8,
        items: [
          baseBottomNavigationBarItem(BottomIcons.newspaper, ""),
          baseBottomNavigationBarItem(BottomIcons.chat, ""),
          baseBottomNavigationBarItem(BottomIcons.dumbbell, ""),
          baseBottomNavigationBarItem(BottomIcons.user, ""),
        ],
        onTap: setCurrentTab,
      ),
      body: SafeArea(
        child: Container(
          child: Center(child: data.screens[data.currentTab]),
        ),
      ),
    );
  }

  setCurrentTab(int index) {
    if (data.currentTab == index) return;

    setState(() {
      data.currentTab = index;
    });
  }

  goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
