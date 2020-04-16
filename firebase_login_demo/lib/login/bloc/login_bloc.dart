import 'package:firebase_login_demo/resource/validators.dart';
import 'package:firebase_login_demo/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
      Stream<LoginEvent> events,
      Stream<LoginState> Function(LoginEvent event) next,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithCredentialPressed) {
      yield* _mapLoginWithCredentialPressedToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithCredentialPressedToState(
      {@required String email, @required String password}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(
          email: email, password: password);
      final bool isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        yield LoginState.success();
      } else {
        throw PlatformException(
            code: "ERROR_SIGN_IN_FAILED", message: "Sign-In failed");
      }
    } catch (error) {
      String errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "ERROR_SIGN_IN_FAILED":
          errorMessage = error.message;
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
//    yield LoginLoading();
    try {
      await _userRepository.signInWithGoogle();
      final bool isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        yield LoginState.success();
      } else {
        throw PlatformException(
            code: "ERROR_SIGN_IN_FAILED", message: "Sign-In failed");
      }
    } catch (error) {
      String errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_CREDENTIAL":
          errorMessage = "Your credential appears to be malformed.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
          errorMessage = "An account with this email id is already exist.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Google accounts are not enabled.";
          break;
        case "ERROR_INVALID_ACTION_CODE":
          errorMessage = "Your login link is malformed, used or expired.";
          break;
        case "ERROR_SIGN_IN_FAILED":
          errorMessage = error.message;
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      yield LoginState.failure();
    }
  }
}
