import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterpoc/home/home.dart';
import 'package:flutterpoc/login/view/login_page.dart';

class PocRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return HomePage.route();
      case '/login':
        return LoginPage.route();
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

class RoutePaths {
  static const String Home = '/';
  static const String Login = '/login';
}
