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
      isCardio;
  int sets, reps, cardioTime, kilograms;

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
      this.cardioTime = 0,
        this.kilograms=0,
      this.isCardio = false,
      this.isRest = false,
      this.isExercise = false});
}
