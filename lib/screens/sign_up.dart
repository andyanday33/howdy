import 'package:flutter/material.dart';
import 'package:howdy/widgets/appBar.dart';
import 'package:howdy/widgets/inputDecoration.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController userNametec = new TextEditingController();
  TextEditingController emailtec = new TextEditingController();
  TextEditingController passwordtec = new TextEditingController();

  signUserUp() {
    FormState? form = formKey.currentState;
    if (form != null) {
      if (form.validate()) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val) {
                        if (val != null) {
                          return val.isEmpty || val.length < 4
                              ? "Please provide a username with more than 3 characters"
                              : null;
                        } else {
                          return "Please provide a username with more than 3 characters";
                        }
                      },
                      controller: userNametec,
                      //decoration for input text
                      style: TextStyle(color: Colors.white),
                      //decoration for text field
                      decoration: textFieldDecoration("Username"),
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val != null) {
                          return EmailValidator.validate(val)
                              ? null
                              : "Please provide a valid e-mail address";
                        } else {
                          return "Please provide a valid e-mail address";
                        }
                      },
                      controller: emailtec,
                      //decoration for input text
                      style: TextStyle(color: Colors.white),
                      //decoration for text field
                      decoration: textFieldDecoration("E-Mail"),
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val != null) {
                          return val.length > 6
                              ? null
                              : "Please provide a password with 7 or more characters";
                        } else {
                          return "Please provide a password with 7 or more characters";
                        }
                      },
                      controller: passwordtec,
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
                            style:
                                TextStyle(color: Colors.white60, fontSize: 16)),
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: GestureDetector(
                        onTap: () {
                          signUserUp();
                        },
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
                          child: Text("Sign Up",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 20)),
                        ),
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
                        child: Text("Sign Up with Google",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 20)),
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
                            Colors.white,
                            Colors.white70,
                          ]),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text("Sign In Instead",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
