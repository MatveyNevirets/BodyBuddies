// ignore_for_file: must_be_immutable

part of 'water_cups_bloc.dart';

@immutable
sealed class WaterCupsEvent {}

class ActivatingCupEvent extends WaterCupsEvent {
  int index;
  ActivatingCupEvent(this.index);
}

class DeactivatingCupEvent extends WaterCupsEvent {
  int index;
  DeactivatingCupEvent(this.index);
}
