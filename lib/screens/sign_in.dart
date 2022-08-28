import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:black/auth_bloc/auth_bloc.dart';
import 'package:black/auth_bloc/auth_event.dart';
import 'package:black/screens/account_confirmation_screen.dart';

import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  AuthenticationBloc authBloc;
  SignIn({Key? key, required this.authBloc}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _username = TextEditingController();

  TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    print("${_username.text} and  ${_password.text}");
    widget.authBloc.add(AuthenticationSignInEvent(
      username: _username.text.trim(),
      password: _password.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 120, left: 20, right: 20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                  controller: _username,
                  decoration: const InputDecoration(
                    labelText: "Username",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Value can not be empty";
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Value can not be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                child: const Text("SignIn"),
              ),
              const SizedBox(height: 8),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      widget.authBloc.add(ShowSignUpScreenEvent());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
