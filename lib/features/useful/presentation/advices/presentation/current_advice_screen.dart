import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
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
          child: SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentAdvice.title,
                    style: Styles.title_blue_text_style,
                  ),
                  Container(
                    height: 3,
                    width: 100,
                    color: Colours.workout_card_background_color,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    currentAdvice.bodyText,
                    style: Styles.body_blue_text_style,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
