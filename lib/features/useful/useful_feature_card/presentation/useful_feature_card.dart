import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/widgets/snackbar.dart';
import 'package:body_buddies/internal/application/di/app_depends_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/strings/strings.dart';
import '../../../../core/styles/styles.dart';

class UsefulFeatureCard extends StatelessWidget {
  const UsefulFeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 15,
                    child: GestureDetector(
                      onTap: () => openPage(context, "/bench_press_calculator"),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color:
                                      Colours.greenContainerGradientColors[0],
                                  blurRadius: 3,
                                  spreadRadius: 0.2),
                              BoxShadow(
                                  color:
                                      Colours.greenContainerGradientColors[1],
                                  blurRadius: 3,
                                  spreadRadius: 0.2),
                            ], borderRadius: BorderRadius.circular(8)),
                            child: const Image(
                              image: AssetImage(
                                  "assets/images/bench_press_calculator_background.png"),
                            ),
                          ),
                          Positioned(
                              left: 23,
                              top: 115,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Strings.calculator,
                                    style: Styles.advices_containers_text_style,
                                  ),
                                  Text(
                                    Strings.bench_presses,
                                    style: Styles.advices_containers_text_style,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 15,
                    child: GestureDetector(
                      onTap: () => openPage(context, "/advices"),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colours.yellowDark,
                                blurRadius: 2,
                                spreadRadius: 0.2,
                                offset: const Offset(0, 1),
                              ),
                              BoxShadow(
                                  color: Colours.yellow,
                                  offset: const Offset(0, -2),
                                  blurRadius: 2,
                                  spreadRadius: 0.2),
                            ], borderRadius: BorderRadius.circular(8)),
                            child: const Image(
                              image: AssetImage(
                                  "assets/images/advice_background.png"),
                            ),
                          ),
                          Positioned(
                              left: 23,
                              top: 115,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Strings.advices,
                                    style: Styles.advices_containers_text_style,
                                  ),
                                  Text(
                                    Strings.beginners,
                                    style: Styles.advices_containers_text_style,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 80,
              ),
              GestureDetector(
                onTap: () => tryOpenDoneWorkouts(context, "/made_workouts"),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colours.redContainerGradientColors[1],
                          blurRadius: 3,
                          spreadRadius: 0.2,
                          offset: const Offset(0, 1),
                        ),
                        BoxShadow(
                            color: Colours.redContainerGradientColors[0],
                            offset: const Offset(0, -2),
                            blurRadius: 3,
                            spreadRadius: 0.2),
                      ], borderRadius: BorderRadius.circular(8)),
                      child: const Image(
                        image: AssetImage(
                            "assets/images/done_workouts_background.png"),
                      ),
                    ),
                    Positioned(
                        left: 22,
                        top: 130,
                        child: Text(
                          "готовые программы тренировок",
                          style: Styles.advices_containers_text_style,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void openPage(BuildContext context, String routePath) {
    Navigator.of(context).pushNamed(routePath);
  }

  void tryOpenDoneWorkouts(BuildContext context, String routePath) {
    final isConnection = AppDependsProvider.of(context).isConnection;

    if (isConnection) {
      Navigator.of(context).pushNamed(routePath);
    } else {
      showSnackBar(context, Strings.haventInternetConnetion);
    }
  }
}
