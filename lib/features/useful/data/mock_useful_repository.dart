import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:body_buddies/features/useful/domain/entity/exercise_on_list_entity.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';

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

  @override
  Future<List<AdviceEntity>> fetchAdvices(String token) async {
    if (token != "") {
      await Future.delayed(const Duration(seconds: 2));
      return [
        AdviceEntity(
            title: "Всё очень просто", bodyText: "Действительно, это так!"),
        AdviceEntity(
            title: "Как есть тортики и не набирать вес?",
            bodyText: "Ешь и не набирай. Каша мяса.")
      ];
    } else {
      throw Exception("Invalid token");
    }
  }
}
