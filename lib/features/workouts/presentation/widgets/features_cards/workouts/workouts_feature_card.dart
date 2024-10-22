import 'package:flutter/cupertino.dart';

import '../../../../../../assets/icons/flutter-icons-ef864561/bottom_icons_icons.dart';
import '../../../../../../core/colors/colors.dart';

import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/styles/styles.dart';
import '../../../../../../core/widgets/base_button.dart';

class WorkoutFeatureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Colours.blueContainerGradientColors,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Wrap(
        children: [
          Container(
            margin: Styles.base_margin_size,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Название программы",
                      //TODO: В БУДУЮЩЕМ ЗДЕСЬ ОПИРАЕТСЯ ВСЁ НА ДАННЫЕ ПОЛЬЗОВАТЕЛЯ
                      style: Styles.medium_dark_boxes_text,
                    ),
                    Text(
                      "Понедельник",
                      //TODO: В БУДУЮЩЕМ ЗДЕСЬ ОПИРАЕТСЯ ВСЁ НА ДАННЫЕ ПОЛЬЗОВАТЕЛЯ
                      style: Styles.small_dark_boxes_text,
                    ),
                    SizedBox(
                      height: Styles.big_height_of_text_to_widget,
                    ),
                    Text(
                      "Грудь, бицепс",
                      //TODO: В БУДУЮЩЕМ ЗДЕСЬ ОПИРАЕТСЯ ВСЁ НА ДАННЫЕ ПОЛЬЗОВАТЕЛЯ
                      style: Styles.medium_dark_boxes_text,
                    )
                  ],
                ),
                Expanded(child: SizedBox()),
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    const Icon(
                      BottomIcons.dumbbell,
                      size: 40,
                      color: Colours.white_text_color,
                    ),
                    const SizedBox(height: 18),
                    BaseButton(
                      onClick: () {},
                      buttonText: Strings.start,
                      icon: null,
                      isElevated: true,
                      backgroundColor: Colours.white_text_color,
                      color: Colours.bottom_bar_icons_color,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
