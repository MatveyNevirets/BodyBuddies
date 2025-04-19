import 'package:body_buddies/features/workouts/domain/Entities/exercise_entity.dart';
import 'package:body_buddies/internal/application/app_consts.dart';

class WorkoutEntity {
  int id;
  String? title;
  int weekday;

  String date, duration;

  List<ExerciseEntity> exercises = [];

  WorkoutEntity({
    required this.title,
    required this.exercises,
    this.date = "",
    this.duration = "",
    this.weekday = -1,
    this.id = -1,
  });

  factory WorkoutEntity.fromMap(Map<String, dynamic> map) {
    return WorkoutEntity(
      id: int.parse(map[AppConsts.idColumn].toString()),
      title: map[AppConsts.titleColumn].toString(),
      exercises: [],
      weekday: int.parse(map[AppConsts.weekdayColumn].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppConsts.titleColumn: title,
      AppConsts.weekdayColumn: weekday,
      AppConsts.dateColumn: date,
      AppConsts.durationColumn: duration,
    };
  }
}
