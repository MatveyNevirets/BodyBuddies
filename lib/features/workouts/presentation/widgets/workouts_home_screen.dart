import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/icons/flutter-icons-ef864561/bottom_icons_icons.dart';

class WorkoutsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Styles.base_magrin_size,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [//TODO: Распределить текст
            const Text("Твои программы", style: Styles.appbar_text_style),
            const SizedBox(
              height: Styles.height_of_text_to_widget,
            ),
            Container(
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
                    margin: Styles.base_magrin_size,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Название программы",
                              style: Styles.medium_dark_boxes_text,
                            ),
                            Text(
                              "Понедельник",
                              style: Styles.small_dark_boxes_text,
                            ),
                            SizedBox(
                              height: Styles.big_height_of_text_to_widget,
                            ),
                            Text(
                              "Грудь, бицепс",
                              style: Styles.medium_dark_boxes_text,
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
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
                              buttonText: "Начать",
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
            )
          ],
        ),
      ),
    );
  }
}
