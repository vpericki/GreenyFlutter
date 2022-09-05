part of 'achievement_bloc.dart';

@immutable
abstract class AchievementState {}

class AchievementInitial extends AchievementState {}

class AchievementLoading extends AchievementState {}

class AllAchievementsInitial extends AchievementState {}

class AllAchievementsLoading extends AchievementState {}

class AllAchievementsLoaded extends AchievementState {
  final List<Achievement> achievements;

  AllAchievementsLoaded({required this.achievements});
}

class AllAchievementsError extends AchievementState {
  final String? message;
  AllAchievementsError(this.message);
}

class SingleAchievementInitial extends AchievementState {}

class SingleAchievementLoading extends AchievementState {}

class SingleAchievementLoaded extends AchievementState {
  final Achievement achievement;

  SingleAchievementLoaded({required this.achievement});
}

class SingleAchievementError extends AchievementState {
  final String? message;

  SingleAchievementError(this.message);
}
