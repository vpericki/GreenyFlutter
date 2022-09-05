import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeny_flutter_app/Presentation/Components/spacers.dart';
import 'package:greeny_flutter_app/Presentation/Screens/Achievements/widgets/build_card.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Achievement/achievement_bloc.dart';

import '../../../../models/achievement.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  final AchievementBloc _achievementBloc = AchievementBloc();

  @override
  void initState() {
    _achievementBloc.add(GetAllAchievements());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("All achievements"),
          automaticallyImplyLeading: false),
      body: _buildAchievementsList(),
    );
  }

  Widget _buildAchievementsList() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _achievementBloc,
        child: BlocListener<AchievementBloc, AchievementState>(
          listener: (context, state) {
            if (state is AllAchievementsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<AchievementBloc, AchievementState>(
            builder: (context, state) {
              if (state is AllAchievementsInitial) {
                return _buildLoading();
              } else if (state is AllAchievementsLoading) {
                return _buildLoading();
              } else if (state is AllAchievementsLoaded) {
                return AchievementBuilder()
                    .buildCard(context, state.achievements);
              } else if (state is AllAchievementsError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
