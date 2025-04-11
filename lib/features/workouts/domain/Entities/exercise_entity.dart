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
}
