import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/strings/strings.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/base_button.dart';

class RegistrationFormScreen extends StatelessWidget {

  final VoidCallback onSuccesRegisration;

  RegistrationFormScreen({super.key, required this.onSuccesRegisration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white.withAlpha(0),),
      body: Wrap(
        children: [
          Container(
            margin: Styles.base_magrin_size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  Strings.registration_text,
                  style: Styles.title_text_style,
                )),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  Strings.enter_your_email,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 30,
                  cursorColor: Colours.bottom_bar_icons_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.hint_email,
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
                  height: 10,
                ),
                Text(
                  Strings.imagine_your_nickname,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 30,
                  cursorColor: Colours.bottom_bar_icons_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.hint_nickname,
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
                  height: 10,
                ),
                Text(
                  Strings.imagine_your_password,
                  style: Styles.medium_text_style,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
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
                  height: 35,
                ),
                Center(
                  child: Container(
                    width: 250,
                    child: BaseButton(
                        onClick: () => onSuccesRegisration.call(),
                        buttonText: Strings.registration_text,
                        icon: null,
                        isElevated: true),
                  ),
                ),
                SizedBox(
                  height: 35,
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
