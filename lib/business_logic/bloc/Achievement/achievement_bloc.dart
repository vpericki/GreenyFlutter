import 'package:bloc/bloc.dart';
import 'package:greeny_flutter_app/business_logic/repositories/achievement_repository.dart';
import 'package:greeny_flutter_app/models/achievement.dart';
import 'package:meta/meta.dart';

part 'achievement_event.dart';
part 'achievement_state.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  AchievementBloc() : super(AchievementInitial()) {
    final AchievementRepository _achievementRepo = AchievementRepository();

    on<GetAllAchievements>((event, emit) async {
      try {
        emit(AllAchievementsLoading());
        final achievementList = await _achievementRepo.getAll();

        if (achievementList.isEmpty) throw Exception();

        emit(AllAchievementsLoaded(achievements: achievementList));
      } on Exception {
        emit(AllAchievementsError("Error fetching achievements!"));
      }
    });

    on<GetSingleAchievement>((event, emit) async {
      try {
        emit(SingleAchievementLoading());
        final achievement = await _achievementRepo.getAchievementById(event.id);
        emit(SingleAchievementLoaded(achievement: achievement));
      } on Exception {
        emit(SingleAchievementError("Error fetching achievement!"));
      }
    });
  }
}
