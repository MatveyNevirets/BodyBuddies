import 'package:body_buddies/features/chats/domain/entity/message_entity.dart';

class Chat {
  List<MessageEntity> friendsMessages = [
    MessageEntity(message: "message", author: "author")
  ];

  List<MessageEntity> usersMessages = [
    MessageEntity(message: "message2", author: "yourself")
  ];
}