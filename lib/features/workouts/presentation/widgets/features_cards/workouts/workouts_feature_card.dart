import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/calendar_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workout_button_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workout_container_text.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/exercise_entity.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workouts_menu/widgets/workout_entities/entity/workout_entity.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/styles/styles.dart';

class WorkoutFeatureCard extends StatelessWidget {
  final FakeWorkoutsDatabase fakeDatabase;

  const WorkoutFeatureCard({super.key, required this.fakeDatabase});

  @override
  Widget build(BuildContext context) {
    void openWorkoutsMenuScreen() =>
        Navigator.of(context).pushNamed("/workouts_menu");

    return GestureDetector(
      onTap: () => openWorkoutsMenuScreen(),
      child: Wrap(
        children: [
          Stack(
            children: [
              const Image(
                  image: AssetImage(
                      "lib/assets/images/WorkoutsCardBackground.png")),
              Positioned(
                child: Container(
                  margin: Styles.base_margin_size * 1.25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WorkoutContainerText(
                              getTodayWorkout().title.toString(), null),
                          const SizedBox(
                            height: Styles.height_of_text_to_widget * 4,
                          ),
                          WorkoutContainerText("Грудь, бицепс", 12),
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CalendarWidget(
                              height: 40, width: 40, text: getDate()),
                          const SizedBox(
                            height: 30,
                          ),
                          WorkoutButtonWidget(
                            () => runCurrentWorkout(context),
                            const Size(80, 45),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void runCurrentWorkout(
    BuildContext context,
  ) {
    Navigator.of(context)
        .pushNamed("workouts_menu/run_workout/", arguments: getTodayWorkout());
  }

  WorkoutEntity getTodayWorkout() {
    final thisWeekDay = DateTime.now().weekday;

    for (int i = 0; i < fakeDatabase.fakeWorkoutEntities.length; i++) {
      if (fakeDatabase.fakeWorkoutEntities[i].weekday == thisWeekDay) {
        return fakeDatabase.fakeWorkoutEntities[i];
      }
    }

    return fakeDatabase.fakeWorkoutEntities[0];
  }

  String getDate() {
    final day = DateTime.now().day;
    final month = DateTime.now().month;

    final date = "$day.${month.toString().padLeft(2, '0')}";
    return date;
  }
}
