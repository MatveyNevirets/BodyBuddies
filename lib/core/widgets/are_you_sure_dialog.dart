import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/styles/styles.dart';
import 'package:body_buddies/core/widgets/base_button.dart';
import 'package:flutter/material.dart';

class AreYouSureDialog extends StatelessWidget {
  final VoidCallback onSubmit;

  const AreYouSureDialog({required this.onSubmit, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 256),
      child: Card(
        shadowColor: Colours.bottom_bar_icons_color,
        elevation: 2,
        child: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colours.base_button_color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    Strings.areYouSure,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                            blurRadius: 4,
                            color: Theme.of(context).focusColor,
                            offset: const Offset(0, 1))
                      ],
                      fontFamily: 'AqumTwo',
                      fontSize: 24,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: BaseButton(
                        onClick: () => Navigator.of(context).pop(),
                        buttonText: Strings.no,
                        icon: null,
                        isElevated: true,
                        radius: 8,
                        backgroundColor: Colours.workoutCardForegroundColor,
                        color: Colours.workout_card_background_color,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 3,
                      child: BaseButton(
                        onClick: () => onSubmit.call(),
                        buttonText: Strings.yes,
                        icon: null,
                        isElevated: true,
                        radius: 8,
                        backgroundColor: Colours.workoutCardForegroundColor,
                        color: Colours.workout_card_background_color,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
