import 'dart:async';
import 'dart:developer';

import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/internal/application/app_runner/app_env.dart';
import 'package:body_buddies/internal/application/di/app_depends.dart';
import 'package:body_buddies/internal/application/presentation/body_buddies_application.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

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
      final getIt = GetIt.I;

      final workoutsRepository = getIt.get<WorkoutsRepository>();
      final usefulRepository = getIt.get<UsefulRepository>();
      final secureStorage = getIt.get<SecureStorage>();
      final authRepository = getIt.get<AuthRepository>();
      final isConnection = getIt.get<bool>(instanceName: "connectionStatus");

      runApp(BodyBuddiesApp(
        workoutsRepository: workoutsRepository,
        usefulRepository: usefulRepository,
        secureStorage: secureStorage,
        authRepository: authRepository,
        isConnection: isConnection,
      ));

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
