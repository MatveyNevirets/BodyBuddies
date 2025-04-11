import 'dart:convert';

import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workout_feature_card/presentation/widgets/calendar_widget.dart';
import 'package:body_buddies/features/workouts/presentation/workout_feature_card/presentation/widgets/workout_button_widget.dart';
import 'package:body_buddies/features/workouts/presentation/workout_feature_card/presentation/widgets/workout_container_text.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/workout_card_on_list.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
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

    final depends = AppDependsProvider.of(context);

    Future<WorkoutEntity> getTodayWorkout() async {
      try {
        final storage = depends.secureStorage;

        final tokenJson = await storage.read(AppConsts.tokenKey);
        final tokenMap = jsonDecode(tokenJson);
        final token = tokenMap['access_token'];

        final thisWeekDay = DateTime.now().weekday;
        final workoutsList =
            await depends.workoutsRepository.fetchAllWorkout(token);

        for (int i = 0; i < workoutsList.length; i++) {
          if (workoutsList[i].weekday == thisWeekDay) {
            return workoutsList[i];
          }
        }
        return workoutsList[0];
      } on Object catch (error, stack) {
        throw Exception("Error: $error, StackTrace: $stack");
      }
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
                                    truncateText(
                                        snapshot.data!.title.toString(), 18),
                                    null);
                              } else if (snapshot.hasError) {
                                return WorkoutContainerText(
                                    Strings.empty, null);
                              }
                              return const SpinKitThreeInOut(
                                color: Colours.white_text_color,
                                size: 30,
                              );
                            },
                          ),
                          const SizedBox(
                            height: Styles.height_of_text_to_widget * 3,
                          ),
                          FutureBuilder(
                            future: getTodayWorkout(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return WorkoutContainerText(
                                    truncateText(
                                        getDayOfWeekOnString(snapshot.data!,
                                            isFullText: true),
                                        18),
                                    null);
                              } else if (snapshot.hasError) {
                                return WorkoutContainerText(
                                    Strings.empty, null);
                              }
                              return const SpinKitThreeInOut(
                                color: Colours.white_text_color,
                                size: 30,
                              );
                            },
                          ),
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CalendarWidget(
                              height: 40, width: 45, text: getDate()),
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
    final day = DateTime.now().day - 10;
    final month = DateTime.now().month;

    final date =
        "${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}";
    return date;
  }
}
