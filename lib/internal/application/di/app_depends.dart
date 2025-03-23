import 'dart:developer';

import 'package:body_buddies/features/auth/data/repository/mock_auth_repository.dart';
import 'package:body_buddies/features/auth/data/repository/prod_auth_repository.dart';
import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/internal/application/app_runner/app_env.dart';

typedef OnProgress = Function(String name, String progress);
typedef OnError = Function(String name, Object error, StackTrace? stack);

enum Depends { auth }

class AppDepends {
  final AppEnv appEnv;
  late final AuthRepository repository;

  AppDepends(this.appEnv);

  Future<void> init(
      {required OnProgress onProgress, required OnError onError}) async {
    try {
      final timer = Stopwatch();
      timer.start();
      repository = switch (appEnv) {
        AppEnv.test => MockAuthRepository(),
        AppEnv.prod => ProdAuthRepository(),
      };
      log("Depend ${repository.name} took ${timer.elapsedMilliseconds}ms to initialize");
      timer.stop();
      onProgress.call(repository.name,
          _calculateProgress(Depends.auth.index, Depends.values.length));
    } on Object catch (error, stack) {
      onError.call(repository.name, error, stack);
    }
  }

  String _calculateProgress(int current, int total) {
    return ((current + 1) / total * 100).toStringAsFixed(0);
  }
}
