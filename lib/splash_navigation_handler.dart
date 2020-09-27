import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpoc/app.dart';
import 'package:flutterpoc/authentication/bloc/authentication_bloc.dart';
import 'package:flutterpoc/router.dart';

class SplashNavigationHandler extends StatelessWidget {
  NavigatorState get _navigator => navigatorKey.currentState;
  final Widget child;

  SplashNavigationHandler(
    this.child, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (ctx, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            _navigator.pushNamedAndRemoveUntil<void>(
              RoutePaths.Home,
              (route) => false,
            );
            break;
          case AuthenticationStatus.unauthenticated:
            _navigator.pushNamedAndRemoveUntil<void>(
              RoutePaths.Login,
              (route) => false,
            );
            break;
          default:
            break;
        }
      },
      child: child,
    );
  }
}
