import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/calendar_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workout_button_widget.dart';
import 'package:body_buddies/features/workouts/presentation/widgets/features_cards/workouts/widgets/workout_container_text.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/styles/styles.dart';

class WorkoutFeatureCard extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    void openWorkoutsMenuScreen() =>
    Navigator.of(context).pushNamed("workouts/home/workouts_menu/");

    return GestureDetector(
      onTap:() => openWorkoutsMenuScreen(),
      child: Wrap(
        children: [
          Stack(
            children: [
              Image(
                  image:
                      AssetImage("lib/assets/images/WorkoutsCardBackground.png")),
              Positioned(
                child: Container(
                  margin: Styles.base_margin_size * 1.25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WorkoutContainerText("Название программы", null),
                          SizedBox(
                            height: Styles.height_of_text_to_widget * 4,
                          ),
                          WorkoutContainerText("Грудь, бицепс", 12),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CalendarWidget(height: 40, width: 40, text: "24.10"),
                          SizedBox(height: 30,),
                          WorkoutButtonWidget(() {}, Size(80, 45),),
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
}
