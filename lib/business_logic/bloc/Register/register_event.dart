part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class Register extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String passwordConfirmation;

  const Register(
      this.username, this.email, this.password, this.passwordConfirmation);
}
