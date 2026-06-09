import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/water_cups_bloc/water_cups_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return WaterCupsBloc(widget.index)..add(InitCupEvent());
      },
      child: BlocBuilder<WaterCupsBloc, WaterCupsState>(
        builder: (context, state) {
          return buildCup(context, state);
        },
        buildWhen: (prev, curr) => prev != curr,
      ),
    );
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

  Widget buildCup(BuildContext context, WaterCupsState state) {
    return GestureDetector(
      onTap: () {
        isDone = !isDone;
        context.read<WaterCupsBloc>().add(!isDone
            ? DeactivatingCupEvent(widget.index)
            : ActivatingCupEvent(widget.index));
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          const Image(
            image: AssetImage("assets/images/water_cup.png"),
            height: 50,
            width: 50,
          ),
          doneIcon(state),
        ],
      ),
    );
  }

  Widget doneIcon(WaterCupsState state) {
    if (state is ActivatedCupState) {
      return const Image(
        image: AssetImage("assets/images/Check.png"),
        height: 10,
        width: 10,
      );
    } else {
      return const SizedBox();
    }
  }
}
