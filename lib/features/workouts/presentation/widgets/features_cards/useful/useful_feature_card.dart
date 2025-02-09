import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/styles/styles.dart';

class UsefulFeatureCard extends StatelessWidget {
  const UsefulFeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Stack(
                    children: [
                      const Image(
                        image: AssetImage(
                            "lib/assets/images/bench_press_calculator_background.png"),
                        height: 160,
                        width: 160,
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
                const SizedBox(
                  width: Styles.height_of_text_to_widget / 2,
                ),
                GestureDetector(
                  child: Stack(
                    children: [
                      const Image(
                        image: AssetImage(
                            "lib/assets/images/advice_background.png"),
                        height: 160,
                        width: 160,
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
              ],
            ),
            SizedBox(
              height: Styles.base_margin_size_double / 2,
            ),
            GestureDetector(
              child: Stack(
                children: [
                  const Image(
                    image: AssetImage(
                        "lib/assets/images/done_workouts_background.png"),
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
    );
  }
}
