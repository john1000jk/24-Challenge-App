import 'package:flutter/material.dart';
import 'package:twenty_four_game/screens/authenticate/register.dart';
import 'package:twenty_four_game/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView,);
    } else {
      return Register(toggleView: toggleView,);
    }
  }
}