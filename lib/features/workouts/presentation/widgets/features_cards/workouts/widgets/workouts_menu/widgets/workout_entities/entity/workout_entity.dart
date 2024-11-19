class WorkoutEntity {
  String? title;
  bool? mon = false,
      tue = false,
      wen = false,
      four = false,
      fri = false,
      sun = false,
      sat = false;

  bool? chest = false,
      back = false,
      legs = false,
      biceps = false,
      triceps = false,
      forearms = false,
      shoulders = false,
      abs = false,
      cardio = false;

  WorkoutEntity(
      {required this.title,
      this.mon,
      this.tue,
      this.wen,
      this.four,
      this.fri,
      this.sun,
      this.sat,
      this.abs,
      this.shoulders,
      this.legs,
      this.triceps,
      this.biceps,
      this.back,
      this.forearms,
      this.chest,
      this.cardio});
}
