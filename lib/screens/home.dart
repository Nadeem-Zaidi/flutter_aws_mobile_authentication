import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  String username;
  Home({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("running in home username=${this.username}");
    return Scaffold(
      body: Center(
        child: Text("Successfully Signed In $username"),
      ),
    );
  }
}
