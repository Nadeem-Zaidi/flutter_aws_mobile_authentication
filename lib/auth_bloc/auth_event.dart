import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationSignUpEvent extends AuthenticationEvent {
  String username;
  String email;
  String phoneNumber;
  String password;

  AuthenticationSignUpEvent(
      {required this.username,
      required this.email,
      required this.phoneNumber,
      required this.password});

  @override
  List<Object> get props => [username, password];
}

class AuthenticationConfirmationEvent extends AuthenticationEvent {
  String username;
  String otpCode;

  AuthenticationConfirmationEvent(
      {required this.otpCode, required this.username});

  @override
  List<Object> get props => [otpCode];
}

class AuthenticationSignInEvent extends AuthenticationEvent {
  String username;

  String password;

  AuthenticationSignInEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class AuthenticationSignOutEvent extends AuthenticationEvent {}

class ConfirmSignInEvent extends AuthenticationEvent {
  String otpCode;
  ConfirmSignInEvent({required this.otpCode});
  @override
  List<Object> get props => [otpCode];
}

class ShowSignUpScreenEvent extends AuthenticationEvent {}

class ConfirmAfterSignUpEvent extends AuthenticationEvent {
  String otpCode;
  String username;

  ConfirmAfterSignUpEvent({required this.otpCode, required this.username});
}
