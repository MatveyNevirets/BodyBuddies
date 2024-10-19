import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/strings/strings.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/base_button.dart';

class CollectCharacteristicScreen extends StatelessWidget {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final VoidCallback onSuccessCollect;
  CollectCharacteristicScreen({super.key, required this.onSuccessCollect});

  @override
  Widget build(BuildContext context) {
    void collectData() {
      print(weightController.text);
      try {
        if (double.parse(heightController.text) > 250 ||
            double.parse(heightController.text) < 120 ||
            double.parse(weightController.text) < 25 ||
            double.parse(weightController.text) > 400) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(Strings.error_weight_or_height)));
        } else {
          onSuccessCollect.call();
          print("Good");
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(Strings.use_dot_please)));
      }

    }

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
                  Strings.collect_data,
                  style: Styles.title_text_style,
                )),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  Strings.your_height,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  cursorColor: Colours.app_bar_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.youe_height_hint,
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
                  Strings.your_weight,
                  style: Styles.medium_text_style,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  cursorColor: Colours.app_bar_color.withAlpha(200),
                  decoration: InputDecoration(
                    hintText: Strings.your_weight_hint,
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
                  height: 70,
                ),
                Center(
                  child: Container(
                    width: 250,
                    child: BaseButton(
                        onClick: () => collectData(),
                        buttonText: Strings.button_done_text,
                        icon: null,
                        isElevated: true),
                  ),
                ),
                SizedBox(
                  height: 100,
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
