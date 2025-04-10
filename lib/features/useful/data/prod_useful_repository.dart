import 'package:body_buddies/features/useful/advices/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/advices/domain/useful_repository.dart';

class ProdUsefulRepository implements UsefulRepository {
  @override
  Future<List<ExerciseOnListEntity>> fetchExercises() {
    // TODO: implement fetchExercises
    throw UnimplementedError();
  }

  @override
  String get name => "Prod useful repository";
}
