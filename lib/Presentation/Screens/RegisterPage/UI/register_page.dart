import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeny_flutter_app/Presentation/Screens/RegisterPage/Widgets/register_btn.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Register/register_bloc.dart';

import '../../../Components/loader.dart';
import '../../../Components/spacers.dart';
import '../../LoginPage/widgets/text_data_widget.dart';
import '../../LoginPage/widgets/text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  late FocusNode usernameFocus;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode passwordConfirmationFocus;

  late FocusNode registerBtnFocus;
  late TextEditingController userName;
  late TextEditingController email;
  late TextEditingController passwordConfirmation;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    usernameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    passwordConfirmationFocus = FocusNode();
    registerBtnFocus = FocusNode();
    userName = TextEditingController();
    email = TextEditingController();
    passwordConfirmation = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    emailFocus.dispose();
    passwordConfirmationFocus.dispose();
    passwordFocus.dispose();
    registerBtnFocus.dispose();
    userName.dispose();
    email.dispose();
    passwordConfirmation.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            buildErrorLayout();
          } else if (state is RegisterSuccess) {
            clearTextData();
            Navigator.of(context).pushNamed('/', arguments: state.message);
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
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
          const TextData(message: "Register"),
          const HeightSpacer(myHeight: 25),
          InputField(
            focusNode: usernameFocus,
            textController: userName,
            label: "Username",
            icons: const Icon(Icons.person, color: Colors.green),
          ),
          const HeightSpacer(myHeight: 25),
          InputField(
            focusNode: emailFocus,
            textController: email,
            label: "Email",
            icons: const Icon(Icons.email, color: Colors.green),
          ),
          const HeightSpacer(myHeight: 25),
          InputField(
            focusNode: passwordFocus,
            textController: password,
            label: "Password",
            icons: const Icon(Icons.lock, color: Colors.green),
          ),
          const HeightSpacer(myHeight: 25),
          InputField(
            focusNode: passwordConfirmationFocus,
            textController: passwordConfirmation,
            label: "Repeat password",
            icons: const Icon(Icons.lock, color: Colors.green),
          ),
          const HeightSpacer(myHeight: 25),
          RegisterBtn(
            focusNode: registerBtnFocus,
            userName: userName,
            email: email,
            password: password,
            passwordConfirmation: password,
          ),
          const HeightSpacer(myHeight: 50),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/"),
            child: const Text("Back to login page"),
          ),
          const HeightSpacer(myHeight: 25),
        ],
      );

  ScaffoldFeatureController buildErrorLayout() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error, please try again'),
        ),
      );

  clearTextData() {
    userName.clear();
    password.clear();
  }
}
