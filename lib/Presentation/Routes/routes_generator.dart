import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeny_flutter_app/Presentation/Screens/Home/UI/home.dart';
import 'package:greeny_flutter_app/Presentation/Screens/RegisterPage/UI/register_page.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Home/home_bloc.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Login/login_bloc.dart';
import 'package:greeny_flutter_app/business_logic/bloc/Register/register_bloc.dart';
import 'package:greeny_flutter_app/business_logic/cubit/Navbar/navbar_cubit.dart';
import 'package:greeny_flutter_app/models/user.dart';

import '../Screens/LoginPage/UI/login_page.dart';

class RouteGenerator {
  final LoginBloc _loginBloc = LoginBloc();
  final RegisterBloc _registerBloc = RegisterBloc();
  final HomeBloc _homeBloc = HomeBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>.value(
            value: _loginBloc,
            child: const MyHomePage(),
          ),
        );

      case '/register':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterBloc>.value(
            value: _registerBloc,
            child: const RegisterPage(),
          ),
        );

      case '/home':
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider<HomeBloc>.value(
              value: _homeBloc,
              child: BlocProvider<NavbarCubit>(
                create: (context) => NavbarCubit(),
                child: const Home(),
              ),
            ),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR IN NAVIGATION'),
        ),
      );
    });
  }
}
