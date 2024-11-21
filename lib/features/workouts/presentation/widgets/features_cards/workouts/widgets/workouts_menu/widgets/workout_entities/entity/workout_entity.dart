import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:flutter/cupertino.dart';

class WorkoutEntity {
  String? title;
  bool mon, tue, wen, thur, fri, sun, sat;

  bool chest, back, legs, biceps, triceps, forearms, shoulders, abs, cardio;

  WorkoutEntity({
    required this.title,
    this.mon = false,
    this.tue = false,
    this.wen = false,
    this.thur = false,
    this.fri = false,
    this.sun = false,
    this.sat = false,
    this.abs = false,
    this.shoulders = false,
    this.legs = false,
    this.triceps = false,
    this.biceps = false,
    this.back = false,
    this.forearms = false,
    this.chest = false,
    this.cardio = false,
  });
}
