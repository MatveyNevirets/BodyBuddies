import 'package:flutter/material.dart';

import '../../../../../../core/themes/themes.dart';

class CalendarWidget extends StatelessWidget {
  final double height;
  final double width;

  final String text;

  const CalendarWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/CalendarIcon.png",
          height: height,
          width: width,
        ),
        Positioned(
          top: height / 1.9,
          left: width / 4.2,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: height / 5,
                fontWeight: FontWeight.w700, // Концепт: Weight 700
                color: DarkTheme.primary, // Концепт: металлический акцент
                fontFamily: "Inter", // Концепт: Inter
                letterSpacing: -0.5, // Концепт: -0.5 для H1
              ),
            ),
          ),
        )
      ],
    );
  }
}
