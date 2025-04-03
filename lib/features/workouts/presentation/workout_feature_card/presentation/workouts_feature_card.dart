import 'dart:developer';

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/workouts/domain/workouts_repository.dart';
import 'package:body_buddies/features/workouts/presentation/workout_feature_card/presentation/widgets/calendar_widget.dart';
import 'package:body_buddies/features/workouts/presentation/workout_feature_card/presentation/widgets/workout_button_widget.dart';
import 'package:body_buddies/features/workouts/presentation/workout_feature_card/presentation/widgets/workout_container_text.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/domain/fake_workouts_database.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../core/styles/styles.dart';

class WorkoutFeatureCard extends StatelessWidget {
  const WorkoutFeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    void openWorkoutsMenuScreen() =>
        Navigator.of(context).pushNamed("/workouts_menu");

    final workoutRepository = AppDependsProvider.of(context).workoutsRepository;

    Future<WorkoutEntity> getTodayWorkout() async {
      final thisWeekDay = DateTime.now().weekday;
      final workoutsList = await workoutRepository.fetchAllWorkout(context);

      for (int i = 0; i < workoutsList.length; i++) {
        if (workoutsList[i].weekday == thisWeekDay) {
          return workoutsList[i];
        }
      }
      return workoutsList[0];
    }

    void runCurrentWorkout(
      BuildContext context,
    ) async {
      Navigator.of(context).pushNamed("workouts_menu/run_workout/",
          arguments: await getTodayWorkout().then((workout) => workout));
    }

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
                          FutureBuilder(
                            future: getTodayWorkout(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return WorkoutContainerText(
                                    snapshot.data!.title.toString(), null);
                              } else if (snapshot.hasError) {
                                throw Exception(
                                    "Error on Workouts Feature Card error: ${snapshot.error}");
                              }
                              return const SpinKitThreeInOut(
                                color: Colours.white_text_color,
                                size: 30,
                              );
                            },
                          ),
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

  String getDate() {
    final day = DateTime.now().day;
    final month = DateTime.now().month;

    final date = "$day.${month.toString().padLeft(2, '0')}";
    return date;
  }
}
