import 'package:flutter/material.dart';
import 'package:greeny_flutter_app/Presentation/Components/spacers.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Achievement/achievement_bloc.dart';
import 'package:greeny_flutter_app/business_logic/repositories/achievement_repository.dart';
import 'package:greeny_flutter_app/models/achievement.dart';

class AchievementDialogBuilder {
  final _achievementRepo = AchievementRepository();

  Future<void> createAchievementDialog(
      BuildContext context, Achievement achievement) async {
    var freshAchievement =
        await _achievementRepo.getAchievementById(achievement.id!);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              '${freshAchievement.name}',
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Required points: ${freshAchievement.requiredPoints}',
                      textAlign: TextAlign.center,
                    ),
                    const HeightSpacer(myHeight: 20.0),
                    const Text(
                      'Users who have achieved this achievement:',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: buildCard(
                            context, freshAchievement.users ?? <Users>[])),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Close'))
            ],
          );
        });
  }

  Widget buildCard(BuildContext context, List<Users> model) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "${model[index].name}",
                  textScaleFactor: 1,
                  style: const TextStyle(color: Colors.black),
                ),
                const HeightSpacer(
                  myHeight: 10.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
