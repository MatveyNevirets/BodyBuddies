import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/chats/domain/entity/fake_user_entity.dart';
import 'package:body_buddies/features/chats/domain/fake_chats_database.dart';
import 'package:body_buddies/features/chats/presentation/widgets/screen_widgets/send_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screen_widgets/chat_with_friend_widget.dart';
import 'screen_widgets/friends_scrollable_widget.dart';

class ChatsScreen extends StatefulWidget {

  final fakeDatabase = FakeChatsDatabase();
  int currentUserId = FriendsScrollableWidget().currentFriend;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: Styles.base_margin_size,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FriendsScrollableWidget(),
              SizedBox(height: MediaQuery.sizeOf(context).height/30,),
              ChatWithFriendWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void FriendChanged(int index) {
    setState(() {
      //fakeUser = fakeDatabase.friends[index];
    });
  }
}
