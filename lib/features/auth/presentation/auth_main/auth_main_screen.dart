import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:flutter/material.dart';

typedef OnSignUp = Function();
typedef OnSignIn = Function({required String email, required String password});

class LoginIntroScreen extends StatelessWidget {
  OnSignIn onSignIn;
  OnSignUp onSignUp;

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
                Center(
                    child: Text(
                  Strings.intro_login_title_text,
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  Strings.intro_enter_login_text,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 30,
                  controller: loginController,
                  style: Theme.of(context).textTheme.bodySmall,
                  cursorColor: Colours.bottom_bar_icons_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.hint_email,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
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
                Text(Strings.intro_login_enter_password_text,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  style: Theme.of(context).textTheme.bodySmall,
                  cursorColor: Colours.bottom_bar_icons_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.hint_password,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
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
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: BaseButton(
                        buttonSize: const Size(double.maxFinite, 50),
                        radius: 8,
                        onClick: () => onSignIn(
                            email: loginController.text,
                            password: passwordController.text),
                        buttonText: Strings.button_login_text,
                        icon: null,
                        isElevated: true),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: BaseButton(
                        radius: 8,
                        buttonSize: const Size(double.maxFinite, 50),
                        onClick: () => onSignUp(),
                        buttonText: Strings.registration_text,
                        icon: null,
                        isElevated: false),
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
