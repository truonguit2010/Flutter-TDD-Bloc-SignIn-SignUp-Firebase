
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

/// 'part' and 'part of' are to split a library into multiple files, not a class.
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User> _userSubscription;

  AuthenticationBloc({@required AuthenticationRepository authenticationRepository})
      : assert (authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {

    _userSubscription = _authenticationRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });
  }

  AuthenticationState _mapAuthenticationUserChangedToState (AuthenticationUserChanged event) {
    return event.user != User.empty ? AuthenticationState.authenticated(event.user) : const AuthenticationState.unauthenticated();
  }

  ///
  ///Marking a function as async or async* allows it to use async/await keyword to use a Future.
  ///
  ///The difference between both is that async* will always returns a Stream and offer some syntax sugar to emit a value through yield keyword.
  ///
  ///We can therefore do the following:
  ///
  ///Stream<int> foo() async* {
  ///  for (int i = 0; i < 42; i++) {
  ///    await Future.delayed(const Duration(seconds: 1));
  ///    yield i;
  ///  }
  ///}
  ///This function emits a value every second, that increment every time
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

}