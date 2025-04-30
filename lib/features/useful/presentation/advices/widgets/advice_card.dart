import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:flutter/material.dart';

GestureDetector buildAdviceCard(
    BuildContext context, int index, List<AdviceEntity> advices) {
  void openCurrentAdvice(
      BuildContext context, String routePath, AdviceEntity currentAdvice) {
    Navigator.of(context).pushNamed(routePath, arguments: currentAdvice);
  }

  return GestureDetector(
    onTap: () =>
        openCurrentAdvice(context, "/advices/current_advice", advices[index]),
    child: SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              width: 3, color: Colours.workout_card_background_color),
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
        elevation: 2,
        shadowColor: Colours.base_button_color,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                advices[index].title,
                style: Styles.reverse_rest_text_style,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
