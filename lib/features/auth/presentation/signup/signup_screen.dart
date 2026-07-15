import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Wrap(
        children: [
          Container(
            margin: DarkTheme.base_margin_size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    Strings.registration_text,
                    style: DarkTheme.title_text_style,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  Strings.enter_your_email,
                  style: DarkTheme.medium_text_style.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: DarkTheme.body_text_style,
                  controller: emailController,
                  maxLength: 30,
                  cursorColor: DarkTheme.primary,
                  decoration: InputDecoration(
                    hintText: Strings.hint_email,
                    counterStyle: DarkTheme.hint_text_style,
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
                  height: 10,
                ),
                Text(
                  Strings.imagine_your_nickname,
                  style: DarkTheme.medium_text_style.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: DarkTheme.body_text_style,
                  controller: usernameController,
                  maxLength: 30,
                  cursorColor: DarkTheme.primary,
                  decoration: InputDecoration(
                    hintText: Strings.hint_nickname,
                    counterStyle: DarkTheme.hint_text_style,
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
                  height: 10,
                ),
                Text(
                  Strings.imagine_your_password,
                  style: DarkTheme.medium_text_style.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: DarkTheme.body_text_style,
                  controller: passwordController,
                  obscureText: true,
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
                        context: context,
                      ),
                      buttonText: Strings.registration_text,
                      buttonSize: const Size(
                        double.maxFinite,
                        50,
                      ),
                      radius: 14,
                      icon: null,
                      isElevated: true,
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

  void _tryRegister({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) {
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
