import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/features/news/domain/fake_database_card_data.dart';
import 'package:body_buddies/features/news/presentation/widgets/cards/default_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  final fakeDatabase = FakeDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: Styles.base_margin_size,
        child: ListView.builder(
          itemCount: fakeDatabase.headerText.length,
          itemBuilder: (context, index) {
            return DefaultCardWidget(
              headerText: fakeDatabase.headerText[index],
              bodyText: fakeDatabase.bodyText[index],
            );
          },
        ),
      ),
    );
  }
}
