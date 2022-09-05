import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:greeny_flutter_app/business_logic/repositories/achievement_repository.dart';
import 'package:greeny_flutter_app/business_logic/secure_storage.dart';
import 'package:greeny_flutter_app/models/user_with_achievements.dart';
import 'package:meta/meta.dart';

import '../../../models/user.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    final _achievementRepo = AchievementRepository();

    on<LoadUserInfo>((event, emit) async {
      try {
        emit(DashboardLoading());
        final userString = await secureStorage.getUserInfo();
        if (userString == null) throw Exception();

        final user = User.fromJson(jsonDecode(userString));
        var userWithAchievemetns =
            await _achievementRepo.getUserAchievements(user.userData!.id!);

        emit(DashboardLoaded(userWithAchievemetns));
      } on Exception {
        emit(DashboardError("Error fetching user data"));
      }
    });
  }
}
