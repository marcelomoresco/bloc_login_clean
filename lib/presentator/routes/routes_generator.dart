import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/home_bloc/home_bloc.dart';
import '../../business_logic/blocs/login_bloc/login_bloc.dart';
import '../screens/home/home_page.dart';
import '../screens/login/UI/login_page.dart';

class RouteGenerator {
  final LoginBloc _loginBloc = LoginBloc();
  final HomeBloc _homeBloc = HomeBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>.value(
            value: _loginBloc,
            child: LoginPage(),
          ),
        );

      case '/home':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider<HomeBloc>.value(
              value: _homeBloc,
              child: HomePage(title: "Home", username: args),
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
