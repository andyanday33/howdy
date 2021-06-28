import 'package:flutter/material.dart';
import 'package:howdy/screens/sign_in.dart';
import 'package:howdy/screens/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignInScreen = true;

  void toggleView() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignInScreen ? SignIn(toggleView) : SignUp(toggleView);
  }
}
