import 'package:flutter/cupertino.dart';

import '../../../../../../core/colors/colors.dart';
import '../../../../../../core/strings/strings.dart';
import '../../../../../../core/styles/styles.dart';
import '../nutrition/widgets/stylised_button.dart';

class UsefulFeatureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: Colours.greenContainerGradientColors,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Wrap(
                    children: [
          Container(alignment: Alignment.center, child: Text("Калькулятор жима"),),
                    ],
                  ),
                ),
                SizedBox(
                  height: Styles.base_margin_size_double /2,
                ),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: Colours.blueContainerGradientColors,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Wrap(
                    children: [
                      Container(alignment: Alignment.center, child: Text("Что-то"),),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: Styles.base_margin_size_double/2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: Colours.yellowContainerGradientColors,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Wrap(
                    children: [
                      Container(alignment: Alignment.center, child: Text("Советы начинающим"),),
                    ],
                  ),
                ),
                SizedBox(
                  height: Styles.base_margin_size_double/2,
                ),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: Colours.redContainerGradientColors,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Wrap(
                    children: [
                      Container(alignment: Alignment.center, child: Text("Готовые программы тренировок"),),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
