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
        child: AppRootView(routeObserver),
      ),
    );
  }
}

class AppRootView extends StatefulWidget {
  AppRootView(this.routeObserver);

  final NavigatorObserver routeObserver;

  @override
  _AppRootViewState createState() => _AppRootViewState(routeObserver);
}

class _AppRootViewState extends State<AppRootView> {
  final NavigatorObserver routeObserver;

  _AppRootViewState(this.routeObserver);

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
