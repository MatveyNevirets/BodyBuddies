// lib/features/water_indicator_widget/water_entity.dart
import 'package:body_buddies/features/water_indicator/bloc/water_cups_bloc/water_cups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class WaterEntity extends StatefulWidget {
  int index;

  WaterEntity(this.index, {super.key});

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
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: activated
                ? const [
                    Color(0xFF2F80ED),
                    Color(0xFF4A9BFF),
                  ]
                : const [
                    Color(0xFF0B1826),
                    Color(0xFF12263A),
                  ],
          ),
          border: Border.all(
            color: activated
                ? const Color(0xFFB8D9FF).withOpacity(0.45)
                : const Color(0xFF244055),
            width: 1.15,
          ),
          boxShadow: activated
              ? [
                  BoxShadow(
                    color: const Color(0xFF2F80ED).withOpacity(0.28),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: const Color(0xFF04101A).withOpacity(0.45),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: activated ? 1 : 0.9,
              child: Image.asset(
                "assets/images/water_cup.png",
                height: 34,
                width: 34,
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: activated ? 1 : 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xFF07131F),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/images/Check.png",
                    height: 10,
                    width: 10,
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
