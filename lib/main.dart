import 'package:flutter/material.dart';
import 'package:howdy/helper/helperfunctions.dart';
import 'package:howdy/screens/sign_in.dart';
import 'package:howdy/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:howdy/helper/authenticate.dart';
import 'package:howdy/screens/chatScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? userIsLoggedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedFromSharedPref().then((val) {
      setState(() {
        userIsLoggedIn = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        primarySwatch: Colors.blue,
      ),
      home: userIsLoggedIn != null
          ? (userIsLoggedIn == true ? ChatScreen() : Authenticate())
          : Authenticate(),
    );
  }
}
