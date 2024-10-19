import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:flutter/material.dart';

class LoginIntroScreen extends StatelessWidget {

  final VoidCallback onRegistration;

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginIntroScreen({super.key, required this.onRegistration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          Container(
            margin: Styles.base_magrin_size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Center(
                    child: Text(
                  Strings.intro_login_title_text,
                  style: Styles.title_text_style,
                )),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  Strings.intro_enter_login_text,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 30,
                  controller: loginController,
                  cursorColor: Colours.bottom_bar_icons_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.hint_email_or_nickname,
                    hintStyle: Styles.hint_text_style,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colours.bottom_bar_icons_color,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                  cursorColor: Colours.bottom_bar_icons_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.hint_password,
                    hintStyle: Styles.hint_text_style,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colours.bottom_bar_icons_color,
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
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 250,
                    child: BaseButton(
                        onClick: () => onRegistration.call(),
                        buttonText: Strings.registration_text,
                        icon: null,
                        isElevated: false),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    Strings.intro_login_mini_info_text,
                    style: Styles.mini_info_text_style,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
