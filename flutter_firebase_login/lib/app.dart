

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authentication/authentication.dart';
import 'package:flutter_firebase_login/home/view/home_page.dart';
import 'package:flutter_firebase_login/login/view/login_page.dart';
import 'package:flutter_firebase_login/splash/splash.dart';
import 'package:flutter_firebase_login/theme.dart';
import 'package:flutter_firebase_login/authentication/authentication.dart';

class App extends StatelessWidget {

  final AuthenticationRepository authenticationRepository;

  App({Key key, @required this.authenticationRepository}) :
        assert(authenticationRepository != null),
        super(key: key);



  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(authenticationRepository: authenticationRepository,),
        child: null,
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppViewState();
  }
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();


  NavigatorState get _navigator => _navigatorKey.currentState;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil(HomePage.route(), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(LoginPage.route(), (route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}