import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:meta/meta.dart';

class DialogCreateEntityCubit extends Cubit<List<ExerciseEntity>> {
  DialogCreateEntityCubit() : super([]);

  void addItem(ExerciseEntity entity) {
    final List<ExerciseEntity> updatedList = List.from(state)..add(entity);
    emit(updatedList);
  }
}
