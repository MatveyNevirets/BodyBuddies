import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/colors/colors.dart';

class SendMessageWidget extends StatelessWidget {
  var messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
          child: TextField(
            style: TextStyle(color: Colours.white_text_color,),
            controller: messageTextController,
            cursorColor: Colours.white_text_color,
            decoration: const InputDecoration(
              hoverColor: Colours.white_text_color,
              labelStyle: TextStyle(color: Colours.white_text_color),
              hintStyle: TextStyle(color: Colours.white_text_color),
              fillColor: Colours.white_text_color,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colours.white_text_color,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colours.white_text_color,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              hintText: "Сообщение",
            ),
          ),
          width: MediaQuery.sizeOf(context).width / 1.8,
          margin: Styles.base_margin_size * 1.5,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.send),
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colours.grey_text_color),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
