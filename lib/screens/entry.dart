import 'package:black/auth_bloc/auth_bloc.dart';
import 'package:black/auth_bloc/auth_event.dart';
import 'package:black/auth_bloc/auth_state.dart';
import 'package:black/screens/account_confirmation_screen.dart';
import 'package:black/screens/home.dart';
import 'package:black/screens/sign_in.dart';
import 'package:black/screens/sign_up.dart';
import 'package:black/screens/sign_up_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:black/amplifyconfiguration.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Entry extends StatefulWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  bool _amplifyConfigured = false;
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              authBloc.add(AuthenticationSignOutEvent());
            },
            icon: Icon(Icons.logout_outlined)),
        title: Text("Authentication Demo"),
      ),
      body: Container(
        child: _amplifyConfigured
            ? BlocConsumer<AuthenticationBloc, AuthenticationState>(
                bloc: authBloc,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is CircularLoaderState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is AuthenticationInitialState) {
                    return SignIn(
                      authBloc: authBloc,
                    );
                  } else if (state is HomeScreenState) {
                    return Home(username: state.user);
                  } else if (state is SignInConfirmationScreenState) {
                    return SignInConfirmationScreen(
                      authBloc: authBloc,
                    );
                  } else if (state is ShowSignUpScreenState) {
                    return SignUp(
                      authBloc: authBloc,
                    );
                  } else if (state is ConfirmAfterSignUpState) {
                    return SignUpConfirmationScreen(
                      authBloc: authBloc,
                      username: state.username,
                    );
                  } else if (state is SignInScreen) {
                    return SignIn(authBloc: authBloc);
                  }
                  return const Center(
                    child: Text("Some thing went wrong"),
                  );
                },
              )
            // ignore: prefer_const_constructors
            : Center(
                // ignore: prefer_const_constructors
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.amber,
                ),
              ),
      ),
    );
  }
}
