import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpoc/authentication/bloc/authentication_bloc.dart';
import 'package:flutterpoc/di/modules.dart';
import 'package:flutterpoc/router.dart';
import 'package:flutterpoc/splash_navigation_handler.dart';
import 'package:flutterpoc/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  App(
    this.routeObserver, {
    Key key,
    @required this.serviceLocator,
  })  : assert(serviceLocator != null),
        super(key: key);

  final ServiceLocator serviceLocator;
  final NavigatorObserver routeObserver;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: serviceLocator.repositories,
      child: BlocProvider<AuthenticationBloc>(
        create: (ctx) => serviceLocator.getAuthBloc(ctx),
        child: AppView(routeObserver),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  AppView(this.routeObserver);

  final NavigatorObserver routeObserver;

  @override
  _AppViewState createState() => _AppViewState(routeObserver);
}

class _AppViewState extends State<AppView> {
  final NavigatorObserver routeObserver;

  _AppViewState(this.routeObserver);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) => PocRouter.generateRoute(settings),
        navigatorKey: navigatorKey,
        builder: (context, child) => SplashNavigationHandler(child));
  }
}
