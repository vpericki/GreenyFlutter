import 'package:greeny_flutter_app/Presentation/Screens/Achievements/widgets/achievement_dialog.dart';

import '../../../../models/achievement.dart';
import 'package:flutter/material.dart';

import '../../../Components/spacers.dart';

class AchievementBuilder {
  Widget buildCard(BuildContext context, List<Achievement> model) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => AchievementDialogBuilder()
                .createAchievementDialog(context, model[index]),
            child: Card(
              color: Colors.green,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "${model[index].name}",
                      textScaleFactor: 1.5,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const HeightSpacer(
                      myHeight: 10.0,
                    ),
                    Text(
                      "Required points: ${model[index].requiredPoints}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
