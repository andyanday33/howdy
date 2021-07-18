import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:howdy/helper/authenticate.dart';
import 'package:howdy/helper/constants.dart';
import 'package:howdy/helper/helperfunctions.dart';
import 'package:howdy/screens/conversation.dart';
import 'package:howdy/screens/searchScreen.dart';
import 'package:howdy/services/database.dart';
import 'package:howdy/widgets/appBar.dart';
import 'package:howdy/services/auth.dart';
import 'package:howdy/screens/sign_in.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  AuthenticationMethods authMethods = new AuthenticationMethods();
  DatabaseOperations databaseOps = new DatabaseOperations();

  Stream? conversationsStream;

  Widget conversationList() {
    return StreamBuilder(
        stream: conversationsStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        (snapshot.data! as QuerySnapshot).docs[index].data()
                            as Map<String, dynamic>;
                    return ConversationTile(
                        data["conversationRoomId"]
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll("${Constants.loggedUsername}", ""),
                        data["conversationRoomId"]);
                  })
              : Container();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseOps.getConversations(Constants.loggedUsername!).then((val) {
      setState(() {
        conversationsStream = val;
      });
    });
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.loggedUsername =
        await HelperFunctions.getUserNameFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Howdy?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        backgroundColor: Colors.amberAccent,
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: conversationList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

class ConversationTile extends StatelessWidget {
  final String userName;
  final String conversationRoomId;
  ConversationTile(this.userName, this.conversationRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(conversationRoomId)));
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.black54, Colors.black45]),
          ),
          child: Row(children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(40)),
                child: Text("${userName.substring(0, 1)}".toUpperCase())),
            SizedBox(
              width: 6,
            ),
            Text(userName,
                style: TextStyle(fontSize: 16, color: Colors.amberAccent))
          ])),
    );
  }
}
