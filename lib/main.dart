import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterpoc/di/modules.dart';
import 'package:flutterpoc/simple_bloc_observer.dart';

import 'app.dart';

ServiceLocator serviceLocator;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  serviceLocator = ActualServiceLocator();
  RouteObserver observer = RouteObserver();

  runApp(App(
    observer,
    serviceLocator: serviceLocator,
  ));
}
