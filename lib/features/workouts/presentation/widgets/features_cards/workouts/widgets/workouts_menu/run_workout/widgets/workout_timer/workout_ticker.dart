class WorkoutTicker {
  Stream<int> workoutTick() {
    return Stream.periodic(const Duration(seconds: 1), (x) => x + 1).take(25600000);
  }
}
