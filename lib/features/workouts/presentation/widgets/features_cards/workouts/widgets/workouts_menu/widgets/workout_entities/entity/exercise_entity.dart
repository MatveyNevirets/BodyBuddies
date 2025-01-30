class ExerciseEntity {
  String title;
  bool chest,
      legs,
      shoulders,
      forearms,
      triceps,
      biceps,
      abs,
      isExercise,
      isRest,
      isTimerExercise;
  int sets,
      reps,
      timerTimeSeconds,
      timerTimeMinutes,
      restTimeInSeconds,
      restTimeInMinutes;

  double kilograms;

  ExerciseEntity(
      {required this.title,
      this.chest = false,
      this.legs = false,
      this.shoulders = false,
      this.forearms = false,
      this.triceps = false,
      this.biceps = false,
      this.abs = false,
      this.reps = 0,
      this.sets = 0,
      this.timerTimeSeconds = 0,
      this.timerTimeMinutes = 0,
      this.kilograms = 0,
      this.restTimeInMinutes = 0,
      this.restTimeInSeconds = 0,
      this.isTimerExercise = false,
      this.isRest = false,
      this.isExercise = false});
}
