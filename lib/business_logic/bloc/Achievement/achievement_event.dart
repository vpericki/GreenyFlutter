part of 'achievement_bloc.dart';

@immutable
abstract class AchievementEvent {}

class GetAllAchievements extends AchievementEvent {}

class GetSingleAchievement extends AchievementEvent {
  final int id;

  GetSingleAchievement(this.id);
}
