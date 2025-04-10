import 'package:body_buddies/features/useful/presentation/advices/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/presentation/advices/domain/useful_repository.dart';

class MockUsefulRepository implements UsefulRepository {
  @override
  Future<List<ExerciseOnListEntity>> fetchExercises(String token) async {
    if (token != "") {
      await Future.delayed(const Duration(seconds: 2));
      return List.generate(
          10,
          (index) =>
              ExerciseOnListEntity(title: "$index exercise", isExercise: true));
    } else {
      throw Exception("Invalid token");
    }
  }

  @override
  String get name => "Mock useful repository";
}
