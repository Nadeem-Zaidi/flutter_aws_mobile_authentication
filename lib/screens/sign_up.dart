import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_core/amplify_core.dart';

import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _awssignup() async {
    try {
      Map<dynamic, dynamic> userAttributes = {
        "user": _username.text,

        // additional attributes as needed
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: _phone.text.trim(),
          password: _password.text.trim(),
          options: CognitoSignUpOptions(userAttributes: {
            CognitoUserAttributeKey.email: _username.text.trim(),
            CognitoUserAttributeKey.phoneNumber: _phone.text.trim(),
          }));
    } on Exception catch (e) {
      print(e);
    }
  }

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    await _awssignup();
    print("${_username.text} and  ${_password.text}");
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
                  controller: _phone,
                  decoration: InputDecoration(
                    labelText: "phone",
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
