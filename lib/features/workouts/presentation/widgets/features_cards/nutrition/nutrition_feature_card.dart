import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/nutrition/widgets/stylised_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/colors/colors.dart';

import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/styles/styles.dart';

class NutritionFeatureCard extends StatelessWidget {
  const NutritionFeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Stack(children: [
          const Image(image: AssetImage("lib/assets/images/NutritionBackground.png")),
          Positioned(
            child: Container(
              margin: Styles.base_margin_size * 1.25,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StylisedButton(null,null,null,true,Colours.white_text_color, null, Styles.nutrition_button_elevate, Strings.you_need_more, "2200ккал", null),
                      const SizedBox(height: Styles.height_of_text_to_widget,),
                      StylisedButton(null,null,null,false, Colours.invisible_color, Colours.white_text_color, 2, "Дневник", null, () {}),
                    ],
                  ),
                  const Expanded(child: SizedBox(),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StylisedButton(const Size(10,54),null,Styles.nutrition_symbol_text_style,false, Colours.invisible_color, Colours.white_text_color, 15, "+", null, () {}),
                      const SizedBox(height: Styles.height_of_text_to_widget,),
                      StylisedButton(const Size(90,50),CrossAxisAlignment.center,null,true, Colours.white_text_color, null, Styles.nutrition_button_elevate, "Прием", "пищи", null),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],)
      ],
    );
  }
}