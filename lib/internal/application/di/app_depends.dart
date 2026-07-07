import 'dart:developer';

import 'package:body_buddies/features/auth/data/repository/mock_auth_repository.dart';
import 'package:body_buddies/features/auth/data/repository/prod_auth_repository.dart';
import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/useful/data/local_useful_sql_database.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/features/useful/data/mock_useful_repository.dart';
import 'package:body_buddies/features/useful/data/prod_useful_repository.dart';
import 'package:body_buddies/features/workouts/data/repository/local/local_workouts_repository.dart';
import 'package:body_buddies/features/workouts/data/datasources/local/workouts_local_sqlite.dart';
import 'package:body_buddies/features/workouts/data/repository/remote/mock_workouts_repository.dart';
import 'package:body_buddies/features/workouts/data/repository/remote/prod_workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/local_workouts_repository.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/bin/firebase_options.dart';
import 'package:body_buddies/internal/application/app_runner/app_env.dart';
import 'package:body_buddies/services/secure_storage/flutter_secure_storage.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

typedef OnProgress = Function(String name, String progress);
typedef OnError = Function(String name, Object error, StackTrace? stack);

enum Depends {
  auth,
  useful,
  secureStorage,
  localDatabase,
  localWorkouts,
  workouts,
  isConnection
}

class AppDepends {
  final AppEnv appEnv;
  bool isConnection = false;
  final getIt = GetIt.instance;

  AppDepends(this.appEnv);

  String _calculateProgress(int current, int total) {
    return ((current + 1) / total * 100).toStringAsFixed(0);
  }

  Future<void> injectDependency<T extends Object>(
      {required OnProgress onProgress,
      required OnError onError,
      required T repository,
      required Depends depend,
      String? instanceName}) async {
    try {
      final timer = Stopwatch()..start();

      if (!getIt.isRegistered<T>()) {
        getIt.registerSingleton<T>(repository, instanceName: instanceName);
      }

      log("Depend ${T.toString()} took ${timer.elapsedMilliseconds}ms to initialize");
      timer.stop();
      onProgress.call(T.toString(),
          _calculateProgress(depend.index, Depends.values.length));
    } on Object catch (error, stack) {
      onError.call(T.toString(), error, stack);
    }
  }

  Future<void> init(
      {required OnProgress onProgress, required OnError onError}) async {
    await dotenv.load(fileName: ".env");

    final connection = await InternetConnection().hasInternetAccess;
    log(connection.toString());

    final LocalDatabase workoutsLocalDatabase = WorkoutsSQLiteLocalDatabase();
    await workoutsLocalDatabase.initDatabase();

    connection ? isConnection = true : isConnection = false;

    await injectDependency<bool>(
        onProgress: onProgress,
        onError: onError,
        repository: isConnection,
        depend: Depends.isConnection,
        instanceName: "connectionStatus");

    if (isConnection) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await injectDependency<LocalDatabase>(
          onProgress: onProgress,
          onError: onError,
          repository: workoutsLocalDatabase,
          depend: Depends.localDatabase);

      await injectDependency<SecureStorage>(
          onProgress: onProgress,
          onError: onError,
          repository: FlutterSecureStorageImpl(),
          depend: Depends.secureStorage);

      if (appEnv == AppEnv.test) {
        await injectDependency<AuthRepository>(
            onProgress: onProgress,
            onError: onError,
            repository: MockAuthRepository(),
            depend: Depends.auth);

        await injectDependency<UsefulRepository>(
            onProgress: onProgress,
            onError: onError,
            repository: MockUsefulRepository(),
            depend: Depends.useful);

        await injectDependency<WorkoutsRepository>(
            onProgress: onProgress,
            onError: onError,
            repository: MockWorkoutsRepository(),
            depend: Depends.workouts);
      } else {
        await injectDependency<AuthRepository>(
            onProgress: onProgress,
            onError: onError,
            repository: ProdAuthRepository(),
            depend: Depends.auth);

        await injectDependency<UsefulRepository>(
            onProgress: onProgress,
            onError: onError,
            repository: ProdUsefulRepository(),
            depend: Depends.useful);

        await injectDependency<WorkoutsRepository>(
            onProgress: onProgress,
            onError: onError,
            repository:
                ProdWorkoutsRepository(localDatabase: workoutsLocalDatabase),
            depend: Depends.workouts);
      }
    }
  }
}
