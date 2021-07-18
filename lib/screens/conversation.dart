import 'package:cloud_firestore/cloud_firestore.dart';
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
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        (snapshot.data! as QuerySnapshot).docs[index].data()
                            as Map<String, dynamic>;
                    return MessageTile(data["message"],
                        data["sentBy"] == Constants.loggedUsername);
                  },
                )
              : Container();
        });
  }

  sendMessage() {
    if (messagetec.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messagetec.text,
        "sentBy": Constants.loggedUsername.toString(),
        "timeStamp": DateTime.now().millisecondsSinceEpoch,
      };
      databaseOps.addConversationMessages(widget.chatroomId, messageMap);
      messagetec.text = "";
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
            ChatMessageList(),
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

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  MessageTile(this.message, this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: isSentByMe
                  ? [Colors.black87, Colors.black54]
                  : [Colors.amberAccent, Colors.amberAccent]),
          borderRadius: isSentByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                  bottomLeft: Radius.circular(22))
              : BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                  bottomRight: Radius.circular(22)),
        ),
        child: Text(message,
            style: TextStyle(
                fontSize: 16, color: isSentByMe ? Colors.white : Colors.black)),
      ),
    );
  }
}
