import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/data/fakeAdvicesDb.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/useful/presentation/advices/domain/entity/advice_entity.dart';
import 'package:flutter/material.dart';

GestureDetector buildAdviceCard(BuildContext context, int index) {
  void openCurrentAdvice(
      BuildContext context, String routePath, AdviceEntity currentAdvice) {
    Navigator.of(context).pushNamed(routePath, arguments: currentAdvice);
  }

  return GestureDetector(
    onTap: () => openCurrentAdvice(
        context, "/advices/current_advice", FakeAdvicesDb.advices[index]),
    child: SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Card(
        elevation: 4,
        color: Colours.workoutCardForegroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                FakeAdvicesDb.advices[index].title,
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
