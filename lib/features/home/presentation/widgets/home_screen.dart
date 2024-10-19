import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/icons/flutter-icons-ef864561/bottom_icons_icons.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_bottom_navigation_bar_item.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ////// тут под перепись
  int currentTab = 2;
  List<Widget> screens = [
    const Text("Это новостной экран"),
    const Text("Тут будут чаты"),
    WorkoutsScreen(),
    const Text("Тут будет твой профиль"),
  ];

  List<String> appbarTitles = ["Новости", "Чаты", "Тренировки", "Профиль"];

  ///до сюда, ибо говно код

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBarWidget(),
      bottomNavigationBar://TODO: УБРАТЬ ГОВНОКОД, РАСПРЕДЕЛИТЬ ПО ОТДЕДЛЬНЫМ ВИДЖЕТАМ
        BottomNavigationBar(
          selectedItemColor: Colours.bottom_bar_icons_color,
          currentIndex: currentTab,
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
          child: Center(child: screens[currentTab]),
        ),
      ),
    );
  }



  AppBar createAppBarWidget() {
    return AppBar(
      actions: [
        IconButton(icon: const Icon(Icons.settings), onPressed: () {},),
        const SizedBox(width: 10,),
      ],
      title: Text(
        appbarTitles[currentTab],
        style: Styles.appbar_text_style,
      ),
    );
  }

  setCurrentTab(int index) {
    if (currentTab == index) return;

    setState(() {
      currentTab = index;
    });
  }
}
