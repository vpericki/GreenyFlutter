import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Login/login_bloc.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Register/register_bloc.dart';

class RegisterBtn extends StatelessWidget {
  const RegisterBtn(
      {Key? key,
      required this.focusNode,
      required this.userName,
      required this.email,
      required this.password,
      required this.passwordConfirmation})
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController userName;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController passwordConfirmation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: OutlinedButton(
        focusNode: focusNode,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green, width: 1),
            minimumSize: const Size(double.infinity, 54),
            backgroundColor: Colors.green[50]),
        onPressed: () {
          BlocProvider.of<RegisterBloc>(context).add(Register(userName.text,
              email.text, password.text, passwordConfirmation.text));
        },
        child: const Text(
          'Register',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
