class Achievement {
  int? id;
  String? name;
  String? description;
  int? requiredPoints;
  String? createdAt;
  String? updatedAt;
  List<Users>? users;

  Achievement(
      {this.id,
      this.name,
      this.description,
      this.requiredPoints,
      this.createdAt,
      this.updatedAt,
      this.users});

  Achievement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    requiredPoints = json['required_points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['required_points'] = this.requiredPoints;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  int? points;
  Null? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Users(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.points,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    points = json['points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? achievementId;
  int? userId;

  Pivot({this.achievementId, this.userId});

  Pivot.fromJson(Map<String, dynamic> json) {
    achievementId = json['achievement_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['achievement_id'] = this.achievementId;
    data['user_id'] = this.userId;
    return data;
  }
}
