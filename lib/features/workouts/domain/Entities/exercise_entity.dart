import 'package:body_buddies/internal/application/app_consts.dart';

class ExerciseEntity {
  String title;
  bool isExercise, isTimerExercise;
  int sets,
      currentSets,
      reps,
      timerTimeSeconds,
      timerTimeMinutes,
      restTimeInSeconds,
      restTimeInMinutes;

  double kilograms;

  ExerciseEntity(
      {required this.title,
      this.currentSets = 1,
      this.reps = 0,
      this.sets = 0,
      this.timerTimeSeconds = 0,
      this.timerTimeMinutes = 0,
      this.kilograms = 0,
      this.restTimeInMinutes = 0,
      this.restTimeInSeconds = 0,
      this.isTimerExercise = false,
      this.isExercise = false});

  Map<String, dynamic> toMap({int? workoutId}) => {
        AppConsts.titleColumn: title,
        AppConsts.repsColumn: reps,
        AppConsts.setsColumn: sets,
        AppConsts.exerciseTimeMinutesColumn: timerTimeMinutes,
        AppConsts.exerciseTimeSecondsColumn: timerTimeSeconds,
        AppConsts.restTimeMinutesColumn: restTimeInMinutes,
        AppConsts.restTimeSecondsColumn: restTimeInSeconds,
        AppConsts.isExercise: isExercise == true ? 1 : 0,
        AppConsts.isTimerExercise: isTimerExercise == true ? 1 : 0,
        AppConsts.weightColumn: kilograms,
        AppConsts.workoutIdColumn: workoutId ?? -1
      };

  factory ExerciseEntity.fromMap(Map<String, dynamic> map) {
    return ExerciseEntity(
        title: map[AppConsts.titleColumn].toString(),
        reps: int.parse(map[AppConsts.repsColumn].toString()),
        sets: int.parse(map[AppConsts.setsColumn].toString()),
        timerTimeMinutes:
            int.parse(map[AppConsts.exerciseTimeMinutesColumn].toString()),
        timerTimeSeconds:
            int.parse(map[AppConsts.exerciseTimeSecondsColumn].toString()),
        restTimeInMinutes:
            int.parse(map[AppConsts.restTimeMinutesColumn].toString()),
        restTimeInSeconds:
            int.parse(map[AppConsts.restTimeSecondsColumn].toString()),
        isExercise: map[AppConsts.isExercise] == 1 ? true : false,
        isTimerExercise: map[AppConsts.isTimerExercise] == 1 ? true : false,
        kilograms: double.parse(map[AppConsts.weightColumn].toString()));
  }
}
