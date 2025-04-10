import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/data/fakeAdvicesDb.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/features/useful/presentation/advices/widgets/advice_card.dart';
import 'package:flutter/material.dart';

class AdvicesScreen extends StatelessWidget {
  const AdvicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          createAppBarWidget(appbarTitle: Strings.advices, context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colours.workout_card_background_color,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: FakeAdvicesDb.advices.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    buildAdviceCard(context, index),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
