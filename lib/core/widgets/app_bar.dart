import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/material.dart';

AppBar createAppBarWidget(
    {required String appbarTitle, required BuildContext context}) {
  final storage = AppDependsProvider.of(context).secureStorage;
  final workoutsRepository = AppDependsProvider.of(context).workoutsRepository;

  return AppBar(
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      const SizedBox(
        width: 5,
      ),
      IconButton(
        icon: const Icon(Icons.exit_to_app),
        onPressed: () {
          storage.delete(AppConsts.tokenKey);
          workoutsRepository.deleteLocalDatabase();
          Navigator.pushReplacementNamed(context, "auth/");
        },
      ),
      const SizedBox(
        width: 10,
      ),
    ],
    title: Text(
      appbarTitle,
      style: Styles.appbar_text_style,
    ),
  );
}
