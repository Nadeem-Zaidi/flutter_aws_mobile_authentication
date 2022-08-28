import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:black/auth_bloc/auth_bloc.dart';
import 'package:black/auth_bloc/auth_event.dart';
import 'package:black/screens/account_confirmation_screen.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  AuthenticationBloc authBloc;
  SignUp({Key? key, required this.authBloc}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _username = TextEditingController();

  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showConfirmationPage = false;
  bool loading = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    print("${_username.text} and  ${_password.text}");
    widget.authBloc.add(
      AuthenticationSignUpEvent(
        username: _username.text.trim(),
        email: _email.text.trim(),
        phoneNumber: _username.text.trim(),
        password: _password.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 200, left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Value can not be empty";
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    labelText: "email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Value can not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Value can not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: Text("SignUp"),
                )
              ],
            ),
          ),
        ));
  }
}
