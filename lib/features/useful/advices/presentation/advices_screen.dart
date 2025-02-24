import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AdvicesScreen extends StatelessWidget {
  const AdvicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBarWidget(appbarTitle: Strings.advices),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          color: Colours.workout_card_background_color,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text("Hello world!"),
            ),
          ),
        ),
      ),
    );
  }
}
