import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:howdy/helper/helperfunctions.dart';
import 'package:howdy/screens/chatScreen.dart';
import 'package:howdy/services/auth.dart';
import 'package:howdy/services/database.dart';
import 'package:howdy/widgets/appBar.dart';
import 'package:howdy/widgets/inputDecoration.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthenticationMethods authMethods = new AuthenticationMethods();
  DatabaseOperations databaseOps = new DatabaseOperations();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailtec = new TextEditingController();
  TextEditingController passwordtec = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot? snapshotUserInfo;

  signIn() {
    FormState? form = formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        setState(() {
          isLoading = true;
        });
        databaseOps.getUserByEmail(emailtec.text).then((val) {
          snapshotUserInfo = val;
          HelperFunctions.saveEmailToSharedPref(
              snapshotUserInfo?.docs[0].get("email"));
          HelperFunctions.saveUserNameToSharedPref(
              snapshotUserInfo?.docs[0].get("name"));
        });

        authMethods
            .signInWithEmailAndPassword(emailtec.text, passwordtec.text)
            ?.then((result) {
          HelperFunctions.saveUserLoggedInToSharedPref(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
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
                        style: TextStyle(color: Colors.white60, fontSize: 16)),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: GestureDetector(
                    onTap: () {
                      signIn();
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
                      child: Text("Sign In",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 20)),
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
                          style:
                              TextStyle(color: Colors.black87, fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
