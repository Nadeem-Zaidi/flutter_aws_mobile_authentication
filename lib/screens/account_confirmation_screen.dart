import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:black/auth_bloc/auth_bloc.dart';
import 'package:black/auth_bloc/auth_event.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class SignInConfirmationScreen extends StatefulWidget {
  AuthenticationBloc authBloc;
  SignInConfirmationScreen({Key? key, required this.authBloc})
      : super(key: key);

  @override
  State<SignInConfirmationScreen> createState() =>
      _SignInConfirmationScreenState();
}

class _SignInConfirmationScreenState extends State<SignInConfirmationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController otp = TextEditingController();

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    widget.authBloc.add(ConfirmSignInEvent(otpCode: otp.text.trim()));
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
                  controller: otp,
                  decoration: InputDecoration(
                    labelText: "Enter OTP",
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
