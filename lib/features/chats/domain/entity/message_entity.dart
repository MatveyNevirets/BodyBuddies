import 'package:flutter/cupertino.dart';

class MessageEntity extends StatelessWidget
{
  late final DateTime sendTime;
  String message;
  String author;

  MessageEntity({required this.message, required this.author});

  @override
  Widget build(BuildContext context) {
    sendTime = DateTime.now();

    return SizedBox();
  }
}