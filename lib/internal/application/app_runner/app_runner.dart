import 'dart:async';
import 'dart:developer';

import 'package:body_buddies/internal/application/app_runner/app_env.dart';
import 'package:body_buddies/internal/application/di/app_depends.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:body_buddies/internal/application/presentation/body_buddies_application.dart';
import 'package:flutter/widgets.dart';

class AppRunner {
  final AppEnv appEnv;
  AppRunner(this.appEnv);

  Future<void> run() async {
    runZonedGuarded(() async {
      _initApp();

      final appDepends = AppDepends(appEnv);
      await appDepends.init(onProgress: (String name, String progress) {
        log("$name has been success initialized, progress: $progress");
      }, onError: (String name, Object error, StackTrace? stack) {
        throw Exception(
            "Error initialize repository: $name Error: $error StackTrace: $stack");
      });

      runApp(
          AppDependsProvider(appDepends: appDepends, child: BodyBuddiesApp()));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        WidgetsBinding.instance.allowFirstFrame();
      });
    }, (error, stack) {
      log("AppRunner error: $error", error: error, stackTrace: stack);
    });
  }

  Future<void> _initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.deferFirstFrame();
  }
}
