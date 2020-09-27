// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterpoc/app.dart';
import 'package:flutterpoc/authentication/authentication.dart';
import 'package:flutterpoc/di/modules.dart';
import 'package:flutterpoc/home/home.dart';
import 'package:mockito/mockito.dart';

class MockServiceLocator extends Mock implements ServiceLocator {}

class MockAuthBloc extends Mock implements AuthenticationBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group("Given the app is opening", () {
    final mockAuthBloc = MockAuthBloc();
    final mockServiceLocator = MockServiceLocator();
    NavigatorObserver mockObserver = MockNavigatorObserver();
    when(mockServiceLocator.repositories)
        .thenAnswer((_) => [RepositoryProvider(create: (context) => [])]);

    Future<void> buildAppBoot(WidgetTester tester) async {
      await tester.pumpWidget(
        App(mockObserver, serviceLocator: mockServiceLocator),
      );
    }

    group("And the user is logged in", () {
      var authenticatedState = AuthenticationState.authenticated(User(
        email: "fakeemail@gmail.com",
        id: "fakeId",
        name: "FakeName",
      ));

      when(mockServiceLocator.getAuthBloc(any)).thenAnswer((_) => mockAuthBloc);
      when(mockAuthBloc.state).thenAnswer((_) => authenticatedState);

      testWidgets("It should navigate to the Home Screen",
          (WidgetTester tester) async {
        await buildAppBoot(tester);
        await tester.pumpAndSettle();
        verify(mockObserver.didPush(any, any));
        expect(find.byType(HomePage), findsOneWidget);
      });
    });
  });
}
