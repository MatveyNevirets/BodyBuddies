class WorkoutTicker {
  Stream<int> workoutTick(int duration) {
    return Stream.periodic(const Duration(seconds: 1), (x) => duration + x + 1)
        .take(25600000);
  }
}
