import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/data/fakeMadeWorkoutsDb.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/useful/bench_press_calculator/presentation/bench_press_calculator_screen.dart';
import 'package:body_buddies/features/workouts/create_workout/presentation/workout_create_screen.dart';
import 'package:body_buddies/features/workouts/workouts_menu/bloc/workouts_menu_bloc.dart';
import 'package:body_buddies/features/workouts/workouts_menu/domain/entity/new_workout_button.dart';
import 'package:body_buddies/features/workouts/workouts_menu/domain/entity/workout_entity.dart';
import 'package:body_buddies/features/workouts/workouts_menu/domain/fake_workouts_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MadeWorkoutsScreen extends StatefulWidget {
  FakeWorkoutsDatabase fakeWorkoutsDatabase;
  MadeWorkoutsScreen({super.key, required this.fakeWorkoutsDatabase});

  @override
  State<MadeWorkoutsScreen> createState() => _MadeWorkoutsScreenState();
}

class _MadeWorkoutsScreenState extends State<MadeWorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBarWidget(appbarTitle: Strings.workouts_appbar),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                itemCount: FakeMadeWorkoutsDb.workouts.length,
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
                              height: MediaQuery.sizeOf(context).height / 10,
                              width: MediaQuery.sizeOf(context).height / 10,
                            ),
                            const Expanded(child: SizedBox()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  truncateText(
                                      FakeMadeWorkoutsDb.workouts[index].title
                                          .toString(),
                                      12),
                                  style: Styles.workout_text_style,
                                ),
                                Text(
                                  getMusclesGroupOnString(
                                      FakeMadeWorkoutsDb.workouts[index]),
                                  style: Styles.workout_text_style2,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                NewWorkoutButton(
                                    title: Strings.add,
                                    () => addWorkout(index, context),
                                    Size(MediaQuery.sizeOf(context).width / 5,
                                        MediaQuery.sizeOf(context).width / 10)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  void addWorkout(int index, BuildContext context) {
    if (widget.fakeWorkoutsDatabase.fakeWorkoutEntities
        .contains(FakeMadeWorkoutsDb.workouts[index])) {
      showSnackBar(context,
          '${Strings.workout} "${FakeMadeWorkoutsDb.workouts[index].title}" ${Strings.alreadyAdded}');
    } else {
      widget.fakeWorkoutsDatabase.fakeWorkoutEntities
          .add(FakeMadeWorkoutsDb.workouts[index]);
      showSnackBar(context,
          '${Strings.workout} "${FakeMadeWorkoutsDb.workouts[index].title}" ${Strings.addedSuccessful}');
    }
  }

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
