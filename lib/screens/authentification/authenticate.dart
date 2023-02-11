import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authentification/regisration.dart';
import 'package:flutter_application_1/screens/authentification/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Registration(toggleView: toggleView);
    }
  }
}
