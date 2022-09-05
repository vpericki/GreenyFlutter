import 'achievement.dart';

class UserAchievements {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? points;
  String? createdAt;
  String? updatedAt;
  List<Achievement>? achievements;
  List<Roles>? roles;

  UserAchievements(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.points,
      this.createdAt,
      this.updatedAt,
      this.achievements,
      this.roles});

  UserAchievements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    points = json['points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['achievements'] != null) {
      achievements = <Achievement>[];
      json['achievements'].forEach((v) {
        achievements!.add(new Achievement.fromJson(v));
      });
    }
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['points'] = this.points;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.achievements != null) {
      data['achievements'] = this.achievements!.map((v) => v.toJson()).toList();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? userId;
  int? achievementId;

  Pivot({this.userId, this.achievementId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    achievementId = json['achievement_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['achievement_id'] = this.achievementId;
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
      this.name,
      this.guardName,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
