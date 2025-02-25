import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/data/fakeAdvicesDb.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/features/useful/advices/domain/entity/advice_entity.dart';
import 'package:flutter/material.dart';

class AdvicesScreen extends StatelessWidget {
  const AdvicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBarWidget(appbarTitle: Strings.advices),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colours.workout_card_background_color,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: FakeAdvicesDb.advices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => openCurrentAdvice(context,
                      "/advices/current_advice", FakeAdvicesDb.advices[index]),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(FakeAdvicesDb.advices[index].title),
                          Text(FakeAdvicesDb.advices[index].dateTime),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void openCurrentAdvice(
      BuildContext context, String routePath, AdviceEntity currentAdvice) {
    Navigator.of(context).pushNamed(routePath, arguments: currentAdvice);
  }
}
