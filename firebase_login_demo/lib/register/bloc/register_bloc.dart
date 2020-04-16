import 'package:firebase_login_demo/register/bloc/bloc.dart';
import 'package:firebase_login_demo/resource/validators.dart';
import 'package:firebase_login_demo/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
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
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
      String email,
      String password,
      ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
          email: email,
          password: password);
      final bool isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        yield RegisterState.success();
      } else {
        throw PlatformException(code: "ERROR_SIGN_IN_FAILED", message: "Sign-In failed");
      }
    } catch (error) {
      String errorMessage;
      switch(error.code) {
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Password is not strong enough.";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Email address is malformed.";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "An account with this email id is already exist.";
          break;
        case "ERROR_SIGN_IN_FAILED":
          errorMessage = error.message;
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      RegisterState.failure();
    }
  }
}
