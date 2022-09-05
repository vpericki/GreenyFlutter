import 'dart:convert';

import 'package:greeny_flutter_app/connection.dart';
import 'package:greeny_flutter_app/models/achievement.dart';
import 'package:greeny_flutter_app/models/user_with_achievements.dart';

class AchievementRepository {
  Future<List<Achievement>> getAll() async {
    var url = "${conn.getUrl()}/api/achievement";

    var response = await httpClient.get(Uri.parse(url),
        headers: await conn.getAuthorizationHeaders());

    if (response.statusCode < 210) {
      Iterable l = json.decode(response.body);
      var result =
          List<Achievement>.from(l.map((model) => Achievement.fromJson(model)));

      return result;
    }

    throw Exception("Error fetching achievements");
  }

  Future<UserAchievements> getUserAchievements(int userId) async {
    var url = "${conn.getUrl()}/api/currentUser/$userId";

    var response = await httpClient.post(Uri.parse(url),
        headers: await conn.getAuthorizationHeaders());

    if (response.statusCode < 210) {
      var userWithAchievements =
          UserAchievements.fromJson(json.decode(response.body)[0]);
      return userWithAchievements;
    }

    throw Exception("Error fetching achievements");
  }

  Future<Achievement> getAchievementById(int achievementId) async {
    var url = "${conn.getUrl()}/api/achievement/$achievementId";

    var response = await httpClient.get(Uri.parse(url),
        headers: await conn.getAuthorizationHeaders());

    if (response.statusCode < 210) {
      var achievement = Achievement.fromJson(json.decode(response.body)[0]);
      return achievement;
    }
    throw Exception("Error fetching achievements");
  }
}
