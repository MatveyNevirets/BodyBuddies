import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      usernameController = TextEditingController();

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
                  controller: emailController,
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
                  controller: usernameController,
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
                  controller: passwordController,
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
                        onClick: () => _tryRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            username: usernameController.text,
                            context: context),
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

  void _tryRegister(
      {required String email,
      required String password,
      required String username,
      required BuildContext context}) {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      showSnackBar(context, Strings.not_full_field_error);
    } else if (password.length < 8) {
      showSnackBar(context, Strings.passwordTooShort);
    } else if (!email.contains("@") || !email.contains(".")) {
      showSnackBar(context, Strings.uncorrectEmail);
    } else if (username.length < 3) {
      showSnackBar(context, Strings.usernameTooShort);
    } else {
      List<String> response = [email, password, username];
      Navigator.pop(context, response);
    }
  }
}
