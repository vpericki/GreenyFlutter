import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Login/login_bloc.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn(
      {Key? key,
      required this.focusNode,
      required this.userName,
      required this.password})
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController userName;
  final TextEditingController password;

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
          BlocProvider.of<LoginBloc>(context)
              .add(Login(userName.text, password.text));
        },
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
