import 'package:body_buddies/features/useful/advices/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/advices/domain/useful_repository.dart';

class MockUsefulRepository implements UsefulRepository {
  @override
  Future<List<ExerciseOnListEntity>> fetchExercises() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(
        10,
        (index) =>
            ExerciseOnListEntity(title: "$index exercise", isExercise: true));
  }

  @override
  String get name => "Mock useful repository";
}
