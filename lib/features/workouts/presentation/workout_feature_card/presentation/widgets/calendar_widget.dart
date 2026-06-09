import 'package:flutter/cupertino.dart';

import '../../../../../../core/colors/colors.dart';

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
                  fontWeight: FontWeight.bold,
                  color: Colours.white_text_color,
                  fontFamily: "AqumTwo"),
            ),
          ),
        )
      ],
    );
  }
}
