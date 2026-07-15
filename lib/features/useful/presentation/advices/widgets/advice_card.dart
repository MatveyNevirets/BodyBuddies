import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:flutter/material.dart';

GestureDetector buildAdviceCard(
  BuildContext context,
  int index,
  List<AdviceEntity> advices,
) {
  void openCurrentAdvice(
    BuildContext context,
    String routePath,
    AdviceEntity currentAdvice,
  ) {
    Navigator.of(context).pushNamed(
      routePath,
      arguments: currentAdvice,
    );
  }

  return GestureDetector(
    onTap: () => openCurrentAdvice(
      context,
      "/advices/current_advice",
      advices[index],
    ),
    child: SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Container(
        decoration: BoxDecoration(
          color: DarkTheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: DarkTheme.divider,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            advices[index].title,
            style: DarkTheme.medium_text_style.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}
