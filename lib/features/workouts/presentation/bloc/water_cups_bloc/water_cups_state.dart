part of 'water_cups_bloc.dart';

@immutable
sealed class WaterCupsState {}

final class WaterCupsInitial extends WaterCupsState {}

class ActivatedCupState extends WaterCupsState {}

class DeactivatedCupState extends WaterCupsState {}
