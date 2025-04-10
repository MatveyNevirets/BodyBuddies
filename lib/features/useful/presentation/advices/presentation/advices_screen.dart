import 'package:body_buddies/core/colors/colors.dart';
import 'package:body_buddies/core/data/fakeAdvicesDb.dart';
import 'package:body_buddies/core/strings/strings.dart';
import 'package:body_buddies/core/widgets/app_bar.dart';
import 'package:body_buddies/core/widgets/loading_screen.dart';
import 'package:body_buddies/features/useful/presentation/advices/presentation/bloc/advices_bloc.dart';
import 'package:body_buddies/features/useful/presentation/advices/widgets/advice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicesScreen extends StatelessWidget {
  const AdvicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          createAppBarWidget(appbarTitle: Strings.advices, context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colours.workout_card_background_color,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AdvicesBloc, AdvicesState>(
              builder: (context, state) {
                if (state is FetchAdvices) {
                  return ListView.builder(
                    itemCount: state.advices.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          buildAdviceCard(context, index, state.advices),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      );
                    },
                  );
                }
                return const LoadingScreen();
              },
            ),
          ),
        ),
      ),
    );
  }
}
