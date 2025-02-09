import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  setDone(bool isTrue) {
    isDone = isTrue;
  }

  bool _buildState(WaterCupsState state) {
    return state is ActivatedCupState || state is DeactivatedCupState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return WaterCupsBloc();
      },
      child: BlocBuilder<WaterCupsBloc, WaterCupsState>(
        builder: (context, state) {
          return buildCup(context, state);
        },
        buildWhen: (previous, current) => _buildState(current),
      ),
    );
  }

  Widget buildCup(BuildContext context, WaterCupsState state) {
    return GestureDetector(
      onTap: () {
        context.read<WaterCupsBloc>().add(isDone
            ? DeactivatingCupEvent(widget.index)
            : ActivatingCupEvent(widget.index));
        setDone(isDone = !isDone);
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          const Image(
            image: AssetImage("lib/assets/images/water_cup.jpg"),
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
        image: AssetImage("lib/assets/images/Check.png"),
        height: 10,
        width: 10,
      );
    } else {
      return const SizedBox();
    }
  }
}
