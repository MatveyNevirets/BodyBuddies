class ReverseTicker {
  Stream<int> reverseTick(int duration) {
    return Stream.periodic(const Duration(seconds: 1), (x) => duration - x - 1);
  }
}
