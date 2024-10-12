import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:flutter/material.dart';

class LoginIntroScreen extends StatelessWidget {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colours.white_text_color,
        title: Text(
          Strings.welcome_intro_appbar_text,
          style: Styles.appbar_text_style,
        ),
        backgroundColor: Colours.app_bar_color,
      ),
      body: Wrap(
        children: [
          Container(
            margin: Styles.base_magrin_size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  Strings.intro_login_title_text,
                  style: Styles.title_text_style,
                )),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  Strings.intro_login_enter_login_text,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: loginController,
                  cursorColor: Colours.app_bar_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.intro_login_textfield_login_text,
                    hintStyle: Styles.hint_text_style,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colours.app_bar_color,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  Strings.intro_login_enter_password_text,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  cursorColor: Colours.app_bar_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.intro_login_textfield_password_text,
                    hintStyle: Styles.hint_text_style,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colours.app_bar_color,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    width: 250,
                    child: BaseButton(
                        onClick: () => print("Do Someth.."),
                        buttonText: Strings.button_login_text,
                        icon: null,
                        isElevated: true),
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                  child: Container(
                    width: 250,
                    child: BaseButton(
                        onClick: () => print("Do Someth.."),
                        buttonText: Strings.button_registration_text,
                        icon: null,
                        isElevated: false),
                  ),
                ),
                SizedBox(height: 40,),
                Center(child: Text(Strings.intro_login_mini_info_text ,style: Styles.mini_info_text_style, textAlign: TextAlign.center,),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
