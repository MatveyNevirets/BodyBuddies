import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withAlpha(0),
      ),
      body: Wrap(
        children: [
          Container(
            margin: Styles.base_margin_size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: Text(
                  Strings.registration_text,
                  style: Styles.title_text_style,
                )),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  Strings.enter_your_email,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 30,
                  cursorColor: Colours.bottom_bar_icons_color.withAlpha(200),
                  decoration: const InputDecoration(
                    hintText: Strings.hint_email,
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
                  height: 10,
                ),
                const Text(
                  Strings.imagine_your_nickname,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 30,
                  cursorColor: Colours.bottom_bar_icons_color.withAlpha(200),
                  decoration: const InputDecoration(
                    hintText: Strings.hint_nickname,
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
                  height: 10,
                ),
                const Text(
                  Strings.imagine_your_password,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
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
                  height: 35,
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: BaseButton(
                        onClick: () => print("try sign up"),
                        buttonText: Strings.registration_text,
                        icon: null,
                        isElevated: true),
                  ),
                ),
                const SizedBox(
                  height: 35,
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
