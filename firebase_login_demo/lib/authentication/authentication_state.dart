
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String displayName;
  AuthenticationAuthenticated({@required this.displayName});

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Auhtenticated(displayName: $displayName)';

}

class AuthenticationUnauthenticated extends AuthenticationState {}