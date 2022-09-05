import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:greeny_flutter_app/business_logic/repositories/auth_repository.dart';
import 'package:greeny_flutter_app/business_logic/secure_storage.dart';
import 'package:greeny_flutter_app/models/user.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final AuthRepository authRepo = AuthRepository();

    on<LoginEvent>((event, emit) async {
      if (event is Login) {
        if (event.email.isEmpty || event.password.isEmpty) {
          emit(LoginError());
        } else {
          emit(LoginLoading());

          try {
            var responseBody =
                await authRepo.login(event.email, event.password);
            var user = User.fromJson(jsonDecode(responseBody));
            await secureStorage.persistUserAndToken(user);
            emit(LoginSuccess(user));
          } catch (e) {
            await secureStorage.deleteAll();
            emit(LoginError());
          }
        }
      }
    });
  }
}
