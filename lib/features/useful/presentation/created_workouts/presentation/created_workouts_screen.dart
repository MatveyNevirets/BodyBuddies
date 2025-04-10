import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/useful/presentation/created_workouts/presentation/bloc/created_workouts_bloc.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/presentation/workouts_menu/widgets/new_workout_button.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedWorkoutsScreen extends StatelessWidget {
  const CreatedWorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBarWidget(
          appbarTitle: Strings.workouts_appbar, context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<CreatedWorkoutsBloc, CreatedWorkoutsState>(
              builder: (context, state) {
                if (state is FetchCreatedWorkoutsState) {
                  return ListView.builder(
                      itemCount: state.workouts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 4,
                            color: Colours.workout_card_background_color,
                            child: Container(
                              padding: EdgeInsets.only(
                                  right: Styles.base_margin_size_double,
                                  top: Styles.base_margin_size_double / 1.5,
                                  bottom: Styles.base_margin_size_double / 1.5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image(
                                    image: const AssetImage(
                                      "lib/assets/images/workout_image.png",
                                    ),
                                    height:
                                        MediaQuery.sizeOf(context).height / 10,
                                    width:
                                        MediaQuery.sizeOf(context).height / 10,
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        truncateText(
                                            state.workouts[index].title
                                                .toString(),
                                            12),
                                        style: Styles.workout_text_style,
                                      ),
                                      Text(
                                        getMusclesGroupOnString(
                                            state.workouts[index]),
                                        style: Styles.workout_text_style2,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      NewWorkoutButton(
                                          title: Strings.add,
                                          () => addWorkout(index, context),
                                          Size(
                                              MediaQuery.sizeOf(context).width /
                                                  5,
                                              MediaQuery.sizeOf(context).width /
                                                  10)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
                return const LoadingScreen();
              },
            ),
          ),
        ),
      ),
    );
  }

  void addWorkout(int index, BuildContext context) {}

  String getMusclesGroupOnString(WorkoutEntity workout) {
    List<String> groups = [];

    if (workout.abs) groups.add(Strings.abs);
    if (workout.forearms) groups.add(Strings.forearms);
    if (workout.biceps) groups.add(Strings.biceps);
    if (workout.back) groups.add(Strings.back);
    if (workout.chest) groups.add(Strings.chest);
    if (workout.triceps) groups.add(Strings.triceps);
    if (workout.shoulders) groups.add(Strings.shoulders);
    if (workout.cardio) groups.add(Strings.cardio);
    if (workout.legs) groups.add(Strings.legs);

    return groups.toString().substring(1, groups.toString().length - 1);
  }
}
