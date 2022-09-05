import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Login/login_bloc.dart';
import 'package:greeny_flutter_app/business_logic/secure_storage.dart';
import 'package:greeny_flutter_app/models/user.dart';

import '../../../Components/loader.dart';
import '../../../Components/spacers.dart';
import '../widgets/login_btn.dart';
import '../widgets/text_data_widget.dart';
import '../widgets/text_form_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode loginBtnFocus;
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkForUserCredentials();
    });

    checkForUserCredentials().then((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/home", arguments: user);
      }
    });

    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    loginBtnFocus = FocusNode();
    userName = TextEditingController();
    password = TextEditingController();
  }

  Future<User?> checkForUserCredentials() async {
    if (await secureStorage.hasToken() && await secureStorage.hasUserInfo()) {
      var userString = await secureStorage.getUserInfo();
      var user = User.fromJson(jsonDecode(userString!));

      return user;
    }

    return null;
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    loginBtnFocus.dispose();
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            buildErrorLayout();
          } else if (state is LoginSuccess) {
            clearTextData();
            Navigator.of(context).pushNamed('/home', arguments: state.user);
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return LoadingWidget(child: buildInitialInput());
          } else {
            return buildInitialInput();
          }
        },
      ),
    );
  }

  Widget buildInitialInput() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextData(message: "Login"),
          const HeightSpacer(myHeight: 25),
          InputField(
            focusNode: usernameFocus,
            textController: userName,
            label: "Username",
            icons: const Icon(Icons.person, color: Colors.green),
          ),
          const HeightSpacer(myHeight: 25),
          InputField(
            focusNode: passwordFocus,
            textController: password,
            label: "Password",
            icons: const Icon(Icons.lock, color: Colors.green),
          ),
          const HeightSpacer(myHeight: 25),
          LoginBtn(
            focusNode: loginBtnFocus,
            userName: userName,
            password: password,
          ),
          const HeightSpacer(myHeight: 50),
          ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed("/register"),
              child: const Text("No account? Click here to register"))
        ],
      );

  ScaffoldFeatureController buildErrorLayout() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong credentials!'),
        ),
      );

  clearTextData() {
    userName.clear();
    password.clear();
  }
}
