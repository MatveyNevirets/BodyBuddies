import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/styles.dart';

class HelloIntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.app_bar_color,
        title: Text(
          Strings.welcome_intro_appbar_text,
          style: Styles.title_text_style,
        ),
      ),
      body: SafeArea(
          child: Container(
        margin: Styles.base_magrin_size,
        child: Column(
          children: [
            Container(
              margin: Styles.base_magrin_size,
              child: Text(
                Strings.intro_decription_2_text,
                style: Styles.body_text_style,
              ),
            ),

            Container(
              margin: Styles.base_magrin_size,
              child: Text(
                Strings.intro_decription_1_text,
                style: Styles.body_text_style,
              ),
            ),

            Container(
              margin: Styles.base_magrin_size,
              child: Text(
                Strings.intro_decription_3_text,
                style: Styles.body_text_style,
              ),
            ),

            Container(child: BaseButton(onClick: () {}, buttonText: Strings.intro_button_letsgo_text, icon: null,))
          ],
        ),
      )),
    );
  }
}
