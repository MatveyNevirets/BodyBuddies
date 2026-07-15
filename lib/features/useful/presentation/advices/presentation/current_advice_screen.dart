import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:flutter/material.dart';

class CurrentAdviceScreen extends StatelessWidget {
  const CurrentAdviceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentAdvice =
        ModalRoute.of(context)!.settings.arguments as AdviceEntity;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: DarkTheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: DarkTheme.divider,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentAdvice.title,
                  style: DarkTheme.title_text_style,
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 2,
                  width: 80,
                  color: DarkTheme.primary,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  currentAdvice.bodyText,
                  style: DarkTheme.body_text_style,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
