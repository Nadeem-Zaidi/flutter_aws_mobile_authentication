import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:black/auth_bloc/auth_bloc.dart';
import 'package:black/auth_bloc/auth_event.dart';
import 'package:black/auth_bloc/auth_state.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class SignUpConfirmationScreen extends StatefulWidget {
  String username;
  AuthenticationBloc authBloc;
  SignUpConfirmationScreen(
      {Key? key, required this.authBloc, required this.username})
      : super(key: key);

  @override
  State<SignUpConfirmationScreen> createState() =>
      _SignUpConfirmationScreenState();
}

class _SignUpConfirmationScreenState extends State<SignUpConfirmationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController otp = TextEditingController();

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    widget.authBloc.add(AuthenticationConfirmationEvent(
        otpCode: otp.text.trim(), username: widget.username));
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
