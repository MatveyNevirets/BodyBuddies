import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultCardWidget extends StatelessWidget {

  String headerText, bodyText;

  DefaultCardWidget({required this.headerText, required this.bodyText});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colours.bottom_bar_icons_color,
        child: Container(
          margin: Styles.base_margin_size,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(headerText, style: Styles.news_card_header_text_style,),
              SizedBox(height: 10,),
              Text(bodyText, style: Styles.news_card_body_text_style,)
            ],
          ),
        ),
      ),
    );
  }
}
