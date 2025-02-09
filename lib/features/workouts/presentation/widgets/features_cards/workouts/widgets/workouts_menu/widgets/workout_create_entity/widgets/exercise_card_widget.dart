import 'package:flutter/material.dart';

import '../../../../../../../../../../../core/styles/styles.dart';

class ExerciseCardWidget extends StatelessWidget {
  final String text;

  const ExerciseCardWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Card(
      margin: const EdgeInsets.all(4),
      child: Row(
        children: [
          Image(
            height: screenSize.height / 12,
            image: const AssetImage(
              "lib/assets/images/calendar.png",
            ),
          ),
          SizedBox(
            width: screenSize.width / 30,
          ),
          Text(
            truncateText(text, 9),
            style: Styles.workout_text_style_week_day,
          ),
        ],
      ),
    );
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}
