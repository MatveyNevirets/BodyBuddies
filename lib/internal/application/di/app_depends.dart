import 'dart:developer';

import 'package:body_buddies/features/auth/data/repository/mock_auth_repository.dart';
import 'package:body_buddies/features/auth/data/repository/prod_auth_repository.dart';
import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/useful/presentation/advices/domain/useful_repository.dart';
import 'package:body_buddies/features/useful/data/mock_useful_repository.dart';
import 'package:body_buddies/features/useful/data/prod_useful_repository.dart';
import 'package:body_buddies/features/workouts/data/mock_workouts_repository.dart';
import 'package:body_buddies/features/workouts/data/prod_workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/internal/application/app_runner/app_env.dart';
import 'package:body_buddies/services/secure_storage/flutter_secure_storage.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';

typedef OnProgress = Function(String name, String progress);
typedef OnError = Function(String name, Object error, StackTrace? stack);

enum Depends { auth, workouts, useful, secureStorage }

class AppDepends {
  final AppEnv appEnv;
  late final AuthRepository repository;
  late final WorkoutsRepository workoutsRepository;
  late final UsefulRepository usefulRepository;
  late final SecureStorage secureStorage;

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

    try {
      final timer = Stopwatch();
      workoutsRepository = switch (appEnv) {
        AppEnv.test => MockWorkoutsRepository(),
        AppEnv.prod => ProdWorkoutsRepository(),
      };
      log("Depend ${workoutsRepository.name} took ${timer.elapsedMilliseconds}ms to initalize");
      timer.stop();
      onProgress.call(workoutsRepository.name,
          _calculateProgress(Depends.workouts.index, Depends.values.length));
    } on Object catch (error, stack) {
      onError.call(workoutsRepository.name, error, stack);
    }

    try {
      final timer = Stopwatch();
      timer.start();
      usefulRepository = switch (appEnv) {
        AppEnv.test => MockUsefulRepository(),
        AppEnv.prod => ProdUsefulRepository(),
      };
      log("Depend ${usefulRepository.name} took ${timer.elapsedMilliseconds}ms to initialize");
      timer.stop();
      onProgress.call(usefulRepository.name,
          _calculateProgress(Depends.useful.index, Depends.values.length));
    } on Object catch (error, stack) {
      onError.call(repository.name, error, stack);
    }

    try {
      final timer = Stopwatch();
      secureStorage = FlutterSecureStorageImpl();
      log("Depend: ${secureStorage.name} took ${timer.elapsedMilliseconds}ms to initialize");
      onProgress.call(
          secureStorage.name,
          _calculateProgress(
              Depends.secureStorage.index, Depends.values.length));
    } on Object catch (error, stack) {
      onError.call(secureStorage.name, error, stack);
    }
  }

  String _calculateProgress(int current, int total) {
    return ((current + 1) / total * 100).toStringAsFixed(0);
  }
}
