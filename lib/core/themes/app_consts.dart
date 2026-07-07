abstract class AppConsts {
  ///local

  static const String workoutsLocalDatabase =
      "bodybuddies_local_workouts_database.db";

  static const String usefulLocalDatabase =
      "bodybuddies_local_useful_database.db";

////////////////////////TABLES//////////////////

  ///workouts -v

  static const workoutsTable = "workouts";
  static const exercisesTable = "exercises";
  static const journalTable = "journal_workouts";
  static const journalExercisesTable = "journal_exercises_workouts";

  ///useful -v

  static const advicesTable = "advices";
  static const doneWorkoutsTable = "done_workouts";
  static var doneExercisesTable = "done_exercises";
  static const exercisesOnListTable = "exercises_on_list";

  //////////////////////COLUMNS///////////////////////

  ///all -v

  static const idColumn = "id";
  static const titleColumn = "title";

  ///workouts -v

  static const weekdayColumn = "weekday";
  static const dateColumn = "date";
  static const durationColumn = "duration";

  ///exercises -v

  static const repsColumn = "reps";
  static const setsColumn = "sets";
  static const exerciseTimeMinutesColumn = "exercise_time_minutes";
  static const exerciseTimeSecondsColumn = "exercise_time_seconds";
  static const restTimeMinutesColumn = "rest_time_minutes";
  static const restTimeSecondsColumn = "rest_time_seconds";
  static const weightColumn = "weight";
  static const isTimerExercise = "is_timer_exercise";
  static const isExercise = "is_exercise";
  static const workoutIdColumn = "workout_id";

  ///advice -v

  static var bodyColumn = "body";

  static String dayConst = "day_when_saved";

  static String isDone = "is_done_cup";
}
