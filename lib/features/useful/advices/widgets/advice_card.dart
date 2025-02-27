import 'package:body_buddies/core/data/fakeAdvicesDb.dart';
import 'package:body_buddies/features/useful/advices/domain/entity/advice_entity.dart';
import 'package:flutter/material.dart';

GestureDetector buildAdviceCard(BuildContext context, int index) {
  void openCurrentAdvice(
      BuildContext context, String routePath, AdviceEntity currentAdvice) {
    Navigator.of(context).pushNamed(routePath, arguments: currentAdvice);
  }

  return GestureDetector(
    onTap: () => openCurrentAdvice(
        context, "/advices/current_advice", FakeAdvicesDb.advices[index]),
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
}
