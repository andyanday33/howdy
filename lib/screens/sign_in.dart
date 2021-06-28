import 'package:flutter/material.dart';
import 'package:howdy/widgets/appBar.dart';
import 'package:howdy/widgets/inputDecoration.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          children: <Widget>[
            TextField(
              //decoration for input text
              style: TextStyle(color: Colors.white),
              //decoration for text field
              decoration: textFieldDecoration("E-Mail"),
            ),
            TextField(
              //decoration for input text
              style: TextStyle(color: Colors.white),
              //decoration for text field
              decoration: textFieldDecoration("Password"),
            ),
            SizedBox(
              height: 9,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Forgot Password?',
                    style: TextStyle(color: Colors.white60, fontSize: 16)),
              ),
            ),
            SizedBox(
              height: 9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.amberAccent,
                    Colors.amber,
                  ]),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text("Sign In",
                    style: TextStyle(color: Colors.black87, fontSize: 20)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.grey,
                    Colors.blueGrey,
                  ]),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text("Sign In with Google",
                    style: TextStyle(color: Colors.black87, fontSize: 20)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: GestureDetector(
                onTap: () {
                  widget.toggleView();
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Colors.white,
                      Colors.white70,
                    ]),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text("Sign Up Instead",
                      style: TextStyle(color: Colors.black87, fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
