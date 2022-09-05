import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    final AuthRepository authRepo = AuthRepository();

    on<Register>((event, emit) async {
      try {
        emit(RegisterInitial());
        if (event.email.isEmpty ||
            event.username.isEmpty ||
            event.password.isEmpty ||
            event.passwordConfirmation.isEmpty) {
          emit(RegisterError());
        } else if (event.password.length < 8 ||
            event.password != event.passwordConfirmation) {
          emit(RegisterError());
        } else {
          emit(RegisterLoading());
          var response = await authRepo.register(event.username, event.email,
              event.password, event.passwordConfirmation);
          emit(RegisterSuccess(response));
        }
      } on Exception {
        emit(RegisterError());
      }
    });
  }
}
