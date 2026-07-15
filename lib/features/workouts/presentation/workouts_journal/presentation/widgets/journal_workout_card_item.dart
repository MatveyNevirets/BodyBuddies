import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/workouts/domain/Entities/workout_entity.dart';
import 'package:body_buddies/features/workouts/presentation/create_workout/presentation/workout_create_screen.dart';
import 'package:flutter/material.dart';

class JournalWorkoutCardItem extends StatelessWidget {
  final WorkoutEntity workout;
  final VoidCallback removeItem;

  const JournalWorkoutCardItem(this.workout,
      {super.key, required this.removeItem});

  @override
  Widget build(BuildContext context) {
    void openCurrentWorkout() {
      Navigator.of(context)
          .pushNamed("workouts_menu/current_workout/", arguments: [workout, 1]);
    }

    return Padding(
      padding: const EdgeInsets.all(8), // Концепт: базовый шаг 8px
      child: GestureDetector(
        onTap: () => openCurrentWorkout(),
        child: Card(
          color: DarkTheme.surface, // Концепт: Surface для карточек
          elevation: 0, // Концепт: теней почти нет
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18), // Концепт: radius 18
          ),
          child: Padding(
            padding:
                const EdgeInsets.all(16), // Концепт: внутри карточек 16-20px
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truncateText(workout.title.toString(), 14),
                      style: DarkTheme.mini_journal_card_text.copyWith(
                        color: DarkTheme.primary, // Основной текст = Primary
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4), // Внутренний отступ
                    Text(
                      "Длительность:",
                      style: DarkTheme.mini_journal_card_text.copyWith(
                        color: DarkTheme.secondary, // Лейбл = Secondary
                      ),
                    ),
                    Text(
                      workout.duration.isNotEmpty
                          ? workout.duration.toString()
                          : "00:00:00",
                      style: DarkTheme.mini_journal_card_text.copyWith(
                        color: DarkTheme.primary, // Данные = Primary
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      workout.date,
                      style: DarkTheme.mini_journal_card_text.copyWith(
                        color: DarkTheme.primary, // Данные = Primary
                      ),
                    ),
                    const SizedBox(
                      height: 12, // Концепт: внутри карточек 12-16px
                    ),
                    GestureDetector(
                      onTap: () => removeItem.call(),
                      child: const Icon(
                        Icons.delete_outline, // Концепт: outline стиль
                        color: DarkTheme.secondary, // Вторичный акцент
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
