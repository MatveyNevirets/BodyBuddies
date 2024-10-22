import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/nutrition/widgets/stylised_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../assets/icons/flutter-icons-ef864561/bottom_icons_icons.dart';
import '../../../../../../core/colors/colors.dart';

import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/styles/styles.dart';
import '../../../../../../core/widgets/base_button.dart';

class NutritionFeatureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Colours.greenContainerGradientColors,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Wrap(
        children: [
          Stack(children: [
            Image(image: AssetImage("lib/assets/images/NutritionBackground.png")),
            Positioned(
              top: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StylisedButton(true, Colours.white_text_color, null, Styles.nutrition_button_elevate, Strings.you_need_more, "2200ккал", () {}),
                  SizedBox(height: Styles.height_of_text_to_widget,),
                  StylisedButton(false, Colours.invisible_color, Colours.white_text_color, 72, "Дневник", null, () {}),
                ],
              ),
            )
          ],)
        ],
      ),
    );
  }
}