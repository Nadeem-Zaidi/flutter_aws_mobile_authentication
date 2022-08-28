import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationSignUpState extends AuthenticationState {}

class AuthenticationConfirmationState extends AuthenticationState {}

class AuthenticationSignInState extends AuthenticationState {
  String username;

  AuthenticationSignInState({required this.username});
  @override
  List<Object> get props => [username];
}

class AuthenticationInitialState extends AuthenticationState {}

class CircularLoaderState extends AuthenticationState {}

class SignInConfirmationScreenState extends AuthenticationState {}

class SignUpConfirmationScreenState extends AuthenticationState {}

class HomeScreenState extends AuthenticationState {
  String user;
  HomeScreenState({required this.user});

  @override
  List<Object> get props => [user];
}

class SignInScreen extends AuthenticationState {}

class SignOutState extends AuthenticationState {}

class ShowSignUpScreenState extends AuthenticationState {}

class ConfirmAfterSignUpState extends AuthenticationState {
  String username;
  ConfirmAfterSignUpState({required this.username});
}
