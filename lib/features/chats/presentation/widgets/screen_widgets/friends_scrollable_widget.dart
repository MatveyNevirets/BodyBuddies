import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/chats/domain/fake_chats_database.dart';
import 'package:body_buddies/features/chats/presentation/widgets/chats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/colors/colors.dart';

class FriendsScrollableWidget extends StatefulWidget {
  int currentFriend = 0;

  @override
  State<FriendsScrollableWidget> createState() =>
      _FriendsScrollableWidgetState();
}

class _FriendsScrollableWidgetState extends State<FriendsScrollableWidget> {
  final fakeChatsDatabase = FakeChatsDatabase();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: Colours.blueContainerGradientColors),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 70,
        width: double.maxFinite,
        child: Container(
          margin: Styles.base_margin_size / 3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: fakeChatsDatabase.friends.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => CurrentFriend(index),
                child: Container(
                  margin: Styles.base_margin_size /
                      (widget.currentFriend == index ? 3 : 2),
                  child: Card(
                    shape: CircleBorder(
                        side: BorderSide(
                            color: widget.currentFriend == index
                                ? Colours.green_text_color
                                : Colours.background_news_card_color,
                            width: widget.currentFriend == index ? 3 : 1)),
                    elevation: 3,
                    child: CircleAvatar(
                      foregroundImage: AssetImage(
                          fakeChatsDatabase.friends[index].avatar_path),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void CurrentFriend(int index) {
    setState(() {
      widget.currentFriend = index;
    });
  }
}
