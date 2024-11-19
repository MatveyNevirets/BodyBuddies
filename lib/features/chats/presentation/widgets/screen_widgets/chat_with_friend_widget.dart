import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/chats/domain/entity/fake_user_entity.dart';
import 'package:body_buddies/features/chats/domain/entity/message_entity.dart';
import 'package:body_buddies/features/chats/presentation/widgets/screen_widgets/send_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/colors/colors.dart';
import 'chat_widget.dart';

class ChatWithFriendWidget extends StatelessWidget {
  FakeUser? currentUser;

  ChatWithFriendWidget({this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    colors: Colours.blueContainerGradientColors)),
            height: MediaQuery.sizeOf(context).height / 1.65,
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height / 10,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        gradient: LinearGradient(
                            colors: Colours.newsCardGradientColor)),
                    child: Container(
                      margin: Styles.base_margin_size,
                      child: Row(
                        children: [
                          CircleAvatar(
                            foregroundImage: AssetImage(currentUser == null
                                ? "lib/assets/images/X.png"
                                : currentUser!.avatar_path),
                          ),
                          SizedBox(
                            width: Styles.height_of_text_to_widget * 2,
                          ),
                          Text(
                              currentUser == null
                                  ? "Не выбран"
                                  : currentUser!.name,
                              style: Styles.news_card_header_text_style),
                        ],
                      ),
                    ),
                  ),
                  //ChatWidget(),
                  SizedBox(height: MediaQuery.sizeOf(context).height / 2.8,),
                  SendMessageWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
