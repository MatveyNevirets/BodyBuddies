// lib/core/widgets/app_bar.dart
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

AppBar createAppBarWidget({
  required String appbarTitle,
  required BuildContext context,
}) {
  final storage = AppDependsProvider.of(context).secureStorage;
  final workoutsRepository = AppDependsProvider.of(context).workoutsRepository;

  const bg = Color(0xFF081624);
  const border = Color(0xFF22405A);
  const text = Color(0xFFF5F8FC);
  const accent = Color(0xFF2F80ED);

  return AppBar(
    backgroundColor: bg,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    toolbarHeight: 68,
    titleSpacing: 20,
    shape: const Border(
      bottom: BorderSide(
        color: border,
        width: 1,
      ),
    ),
    title: Text(
      appbarTitle,
      style: const TextStyle(
        color: text,
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Material(
          color: accent.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              storage.delete(dotenv.env['TOKEN_KEY']!);
              workoutsRepository.deleteLocalDatabase();
              Navigator.pushReplacementNamed(context, "auth/");
            },
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Icon(
                Icons.logout_rounded,
                color: text,
                size: 22,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
