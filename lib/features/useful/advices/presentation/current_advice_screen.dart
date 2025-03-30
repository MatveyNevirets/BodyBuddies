import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/features/useful/advices/domain/entity/advice_entity.dart';
import 'package:flutter/material.dart';

class CurrentAdviceScreen extends StatelessWidget {
  const CurrentAdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentAdvice =
        ModalRoute.of(context)!.settings.arguments as AdviceEntity;

    return Scaffold(
      appBar:
          createAppBarWidget(appbarTitle: Strings.advices, context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Card(
            color: Colours.workout_card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        currentAdvice.title,
                      ),
                      Text(currentAdvice.dateTime),
                    ],
                  ),
                  Text(currentAdvice.bodyText),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
