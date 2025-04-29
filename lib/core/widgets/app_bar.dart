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
        icon: Icon(
          Icons.exit_to_app,
          color: Theme.of(context).appBarTheme.iconTheme!.color,
        ),
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
      style: Theme.of(context).textTheme.titleLarge,
    ),
  );
}
