import 'package:body_buddies/features/useful/presentation/advices/domain/entity/exercise_on_list_entity.dart';

abstract interface class UsefulRepository {
  String get name;

  Future<List<ExerciseOnListEntity>> fetchExercises(String token);
}
