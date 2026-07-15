import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:flutter/material.dart';

typedef OnSignUp = Function();
typedef OnSignIn = Function({
  required String email,
  required String password,
});

class LoginIntroScreen extends StatelessWidget {
  OnSignIn onSignIn;
  OnSignUp onSignUp;

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginIntroScreen({
    super.key,
    required this.onSignUp,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          Container(
            margin: DarkTheme.base_margin_size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Center(
                  child: Text(
                    Strings.intro_login_title_text,
                    style: DarkTheme.title_text_style,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  Strings.intro_enter_login_text,
                  style: DarkTheme.medium_text_style.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 30,
                  controller: loginController,
                  style: DarkTheme.body_text_style,
                  cursorColor: DarkTheme.primary,
                  decoration: InputDecoration(
                    hintText: Strings.hint_email,
                    hintStyle: DarkTheme.hint_text_style,
                    filled: true,
                    fillColor: DarkTheme.surface,
                    contentPadding: const EdgeInsets.all(14),
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 1,
                        color: DarkTheme.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 1,
                        color: DarkTheme.divider,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  Strings.intro_login_enter_password_text,
                  style: DarkTheme.medium_text_style.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  style: DarkTheme.body_text_style,
                  cursorColor: DarkTheme.primary,
                  decoration: InputDecoration(
                    hintText: Strings.hint_password,
                    hintStyle: DarkTheme.hint_text_style,
                    filled: true,
                    fillColor: DarkTheme.surface,
                    contentPadding: const EdgeInsets.all(14),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 1,
                        color: DarkTheme.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 1,
                        color: DarkTheme.divider,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                      radius: 14,
                      onClick: () => onSignIn(
                        email: loginController.text,
                        password: passwordController.text,
                      ),
                      buttonText: Strings.button_login_text,
                      icon: null,
                      isElevated: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: BaseButton(
                      radius: 14,
                      buttonSize: const Size(double.maxFinite, 50),
                      onClick: () => onSignUp(),
                      buttonText: Strings.registration_text,
                      icon: null,
                      isElevated: false,
                    ),
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
