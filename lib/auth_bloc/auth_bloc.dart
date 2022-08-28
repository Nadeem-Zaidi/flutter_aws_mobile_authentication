import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:black/auth_bloc/auth_event.dart';
import 'package:black/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationSignUpEvent>(_signUp);
    on<AuthenticationConfirmationEvent>(_confirmSignUp);
    on<AuthenticationSignInEvent>(_signIn);
    on<AuthenticationSignOutEvent>(_signOut);
    on<ConfirmSignInEvent>(_confirmSignIn);
    on<ShowSignUpScreenEvent>((event, emit) {
      emit(CircularLoaderState());
      emit(ShowSignUpScreenState());
    });
  }

  Future<void> _signUp(AuthenticationSignUpEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(CircularLoaderState());
    try {
      SignUpResult res = await Amplify.Auth.signUp(
        username: event.username,
        password: event.password,
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: event.email,
            CognitoUserAttributeKey.phoneNumber: event.phoneNumber,
          },
        ),
      );
      emit(CircularLoaderState());
      if (res.isSignUpComplete) {
        emit(ConfirmAfterSignUpState(username: event.username));
      }
    } on Exception catch (e) {
      print("Error in SignUp please try again -->$e");
    }
  }

  Future<void> _confirmSignUp(AuthenticationConfirmationEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(CircularLoaderState());
    try {
      SignUpResult result = await Amplify.Auth.confirmSignUp(
          username: event.username, confirmationCode: event.otpCode);

      if (result.isSignUpComplete) {
        emit(CircularLoaderState());
        emit(SignInScreen());
      }
    } on AuthException catch (e) {
      print("Error in ConfirmingAccount please try again -->$e");
    }
  }

  Future<void> _signIn(AuthenticationSignInEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(CircularLoaderState());
    try {
      final result = await Amplify.Auth.signIn(
        username: event.username,
        password: event.password,
      );

      emit(SignInConfirmationScreenState());
      // if (result.isSignedIn == true) {
      //   print("running inside the sign in ");
      //   final user = await Amplify.Auth.getCurrentUser();
      //   emit(HomeScreen(user: user.username));
      // }
    } on AuthException catch (e) {
      print("Error in Signing in  please try again -->$e");
    }
  }

  Future<void> _signOut(AuthenticationSignOutEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(CircularLoaderState());
    try {
      await Amplify.Auth.signOut();
      emit(AuthenticationInitialState());
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> _confirmSignIn(
      ConfirmSignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(CircularLoaderState());
    var res =
        await Amplify.Auth.confirmSignIn(confirmationValue: event.otpCode);
    print("whether signin or not hurray ${res.isSignedIn}");
    emit(CircularLoaderState());
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    emit(HomeScreenState(user: authUser.username));
  }

  Future<void> _signupscreen(
      ShowSignUpScreenEvent event, Emitter<AuthenticationState> emit) async {
    emit(CircularLoaderState());
    emit(ShowSignUpScreenState());
  }
}
