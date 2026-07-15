import 'package:body_buddies/core/themes/themes.dart';
import 'package:body_buddies/features/water_indicator/bloc/water_cups_bloc/water_cups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class WaterEntity extends StatefulWidget {
  final int index;

  const WaterEntity(this.index, {super.key});

  @override
  State<WaterEntity> createState() => _WaterEntityState();
}

class _WaterEntityState extends State<WaterEntity> {
  bool isDone = false;
  SharedPreferences? _prefs;

  Future<SharedPreferences> getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveState(String key, bool value) async {
    final prefs = await getPrefs();
    await prefs.setBool(key, value);
  }

  Future<bool> getState(String key) async {
    final prefs = await getPrefs();
    final state = prefs.getBool(key);
    if (state == null) {
      return false;
    } else {
      isDone = state;
      return state;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return WaterCupsBloc(widget.index)..add(InitCupEvent());
      },
      child: BlocBuilder<WaterCupsBloc, WaterCupsState>(
        buildWhen: (prev, curr) => prev != curr,
        builder: (context, state) {
          return _buildCup(context, state);
        },
      ),
    );
  }

  Widget _buildCup(BuildContext context, WaterCupsState state) {
    final activated = state is ActivatedCupState;

    return GestureDetector(
      onTap: () {
        isDone = !isDone;
        context.read<WaterCupsBloc>().add(
              !isDone
                  ? DeactivatingCupEvent(widget.index)
                  : ActivatingCupEvent(widget.index),
            );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: activated ? DarkTheme.primary : DarkTheme.surface,
          border: Border.all(
            color: activated ? DarkTheme.primary : DarkTheme.divider,
            width: 1.5,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Иконка стакана воды
            Opacity(
              opacity: activated ? 1.0 : 0.5,
              child: Image.asset(
                "assets/images/water_cup.png",
                height: 34,
                width: 34,
              ),
            ),
            // Галочка в правом нижнем углу (только когда активирован)
            Positioned(
              right: 4,
              bottom: 4,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: activated ? 1.0 : 0.0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: DarkTheme.background,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 12,
                    color: DarkTheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
