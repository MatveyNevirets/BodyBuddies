import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:flutter/material.dart';

class LoginIntroScreen extends StatelessWidget {
  final VoidCallback onSignUp, onSignIn;

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginIntroScreen({super.key, required this.onSignUp, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          Container(
            margin: Styles.base_margin_size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Center(
                    child: Text(
                  Strings.intro_login_title_text,
                  style: Styles.title_text_style,
                )),
                const SizedBox(
                  height: 70,
                ),
                const Text(
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
                  decoration: const InputDecoration(
                    hintText: Strings.hint_email_or_nickname,
                    hintStyle: Styles.hint_text_style,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colours.bottom_bar_icons_color,
                      ),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
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
                  decoration: const InputDecoration(
                    hintText: Strings.hint_password,
                    hintStyle: Styles.hint_text_style,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colours.bottom_bar_icons_color,
                      ),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: BaseButton(
                        onClick: () => onSignIn.call(),
                        buttonText: Strings.button_login_text,
                        icon: null,
                        isElevated: true),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: BaseButton(
                        onClick: () => onSignUp.call(),
                        buttonText: Strings.registration_text,
                        icon: null,
                        isElevated: false),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Center(
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
