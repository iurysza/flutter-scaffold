import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpoc/authentication/authentication.dart';
import 'package:flutterpoc/login/cubit/login_cubit.dart';

class ActualServiceLocator extends ServiceLocator {
  @override
  List<RepositoryProvider> repositories = [
    RepositoryProvider<AuthenticationRepository>(
        create: (_) => AuthenticationRepository())
  ];

  @override
  LoginCubit getLoginCubit(BuildContext context) {
    return LoginCubit(
      context.repository<AuthenticationRepository>(),
    );
  }

  @override
  AuthenticationBloc getAuthBloc(BuildContext context) {
    return AuthenticationBloc(
      authenticationRepository: context.repository<AuthenticationRepository>(),
    );
  }
}

class MockServiceLocator extends ServiceLocator {
  @override
  List<RepositoryProvider> repositories = [
    RepositoryProvider(create: (context) => AuthenticationRepository())
  ];

  @override
  AuthenticationBloc getAuthBloc(BuildContext context) {
    // TODO: implement getAuthBloc
    throw UnimplementedError();
  }

  @override
  LoginCubit getLoginCubit(BuildContext context) {
    // TODO: implement getLoginCubit
    throw UnimplementedError();
  }


}

abstract class ServiceLocator {
  List<RepositoryProvider> repositories = [];

  LoginCubit getLoginCubit(BuildContext context);

  AuthenticationBloc getAuthBloc(BuildContext context);
}
