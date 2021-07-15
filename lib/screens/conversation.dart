import 'package:flutter/material.dart';
import 'package:howdy/helper/constants.dart';
import 'package:howdy/services/database.dart';
import 'package:howdy/widgets/appBar.dart';

class ConversationScreen extends StatefulWidget {
  String chatroomId;
  ConversationScreen(this.chatroomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messagetec = new TextEditingController();

  DatabaseOperations databaseOps = new DatabaseOperations();

  Stream? chatMessageStream;

  Widget ChatMessageList() {
    // return StreamBuilder(
    //   stream: chatMessageStream,
    //   builder: (context, snapshot){
    //     return ListView.builder(
    //       itemCount: snapshot.data?.,
    //     )
    //   }
    // )
    return Scaffold();
  }

  sendMessage() {
    if (messagetec.text.isNotEmpty) {
      Map<String, String> messageMap = {
        "message": messagetec.text,
        "sentBy": Constants.loggedUsername.toString(),
      };
      databaseOps.addConversationMessages(widget.chatroomId, messageMap);
    }
  }

  @override
  void initState() {
    databaseOps.getConversationMessages(widget.chatroomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white12,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: messagetec,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Send a message...",
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.white30, Colors.white38]),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
