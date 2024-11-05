import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultCardWidget extends StatelessWidget {
  String headerText, bodyText;
  String imagePath;

  DefaultCardWidget(
      {required this.headerText,
      required this.bodyText,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colours.background_news_card_color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Colours.newsCardGradientColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            margin: Styles.base_margin_size,
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            headerText,
                            style: Styles.news_card_header_text_style,
                          ),
                          Expanded(child: SizedBox()),
                          CircleAvatar(
                            backgroundImage: AssetImage(imagePath),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        bodyText,
                        style: Styles.news_card_body_text_style,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
