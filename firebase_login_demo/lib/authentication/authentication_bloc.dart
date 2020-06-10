import 'package:bloc/bloc.dart';
import 'package:firebase_login_demo/user_repository.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : _userRepository = userRepository,
        assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(
      AppStarted appStarted) async* {
    try {
      yield AuthenticationLoading();

//      final bool isSignedIn = await _userRepository.isSignedIn();
      final bool isSignedIn = true;
      if (isSignedIn) {
//        yield AuthenticationAuthenticated(displayName: (await _userRepository.getUser()).email);
        yield AuthenticationAuthenticated(displayName: 'Abc');
      } else {
        yield AuthenticationUnauthenticated();
      }
    } catch (_) {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn loggedIn) async* {
    yield AuthenticationAuthenticated(displayName: (await _userRepository.getUser()).email);
  }

  Stream<AuthenticationState> _mapLoggedOutToState(LoggedOut loggedOut) async* {
    yield AuthenticationUnauthenticated();
    _userRepository.signOut();
  }
}
