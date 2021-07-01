import 'package:flutter/material.dart';
import 'package:howdy/models/customuser.dart';
import 'package:howdy/screens/chatScreen.dart';
import 'package:howdy/widgets/appBar.dart';
import 'package:howdy/widgets/inputDecoration.dart';
import 'package:email_validator/email_validator.dart';
import 'package:howdy/services/auth.dart';
import 'package:howdy/services/database.dart';
import 'package:howdy/helper/helperfunctions.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthenticationMethods authMethods = new AuthenticationMethods();
  DatabaseOperations databaseOps = new DatabaseOperations();

  final formKey = new GlobalKey<FormState>();
  TextEditingController userNametec = new TextEditingController();
  TextEditingController emailtec = new TextEditingController();
  TextEditingController passwordtec = new TextEditingController();

  signUserUp() async {
    FormState? form = formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        Map<String, String> userMap = {
          "name": userNametec.text,
          "email": emailtec.text
        };

        HelperFunctions.saveUserNameToSharedPref(userNametec.text);
        HelperFunctions.saveEmailToSharedPref(emailtec.text);

        setState(() {
          isLoading = true;
        });

        CustomUser? val = await authMethods.signInWithEmailAndPassword(
            emailtec.text, passwordtec.text);

        databaseOps.saveUserInfo(userMap);
        if (val != null) {
          print("${val.userId}");
          HelperFunctions.saveUserLoggedInToSharedPref(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: isLoading
          ? Center(
              child: Container(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
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
                            obscureText: true,
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
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 16)),
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: GestureDetector(
                              onTap: () async {
                                await signUserUp();
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
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 20)),
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
                                child: Text("Sign In Instead",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 20)),
                              ),
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
