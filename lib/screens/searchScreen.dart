import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:howdy/services/database.dart';
import 'package:howdy/widgets/appBar.dart';
import 'package:howdy/widgets/inputDecoration.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchtec = new TextEditingController();
  DatabaseOperations databaseOps = new DatabaseOperations();

  QuerySnapshot? searchSnapshot;

  initiateSearchUser() {
    databaseOps.getUserByUsername(searchtec.text).then((result) => {
          setState(() {
            print(result);
            print("hello from initiates");
            searchSnapshot = result;
            print(searchSnapshot?.docs.length);
          })
        });
  }

  getLength(QuerySnapshot? qs) {
    if (qs != null) {
      return qs.docs.length;
    } else {
      return 0;
    }
  }

  //Create a conversation room, send user to this conversation screen
  createConversation(String username) {
    List<String> users = [username];
    //databaseOps.createConversation()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: Container(
          child: Column(
        children: [
          Container(
            color: Colors.black12,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: searchtec,
                  decoration: textFieldDecoration("search username..."),
                )),
                GestureDetector(
                  onTap: () {
                    print("You tapped bro!");
                    initiateSearchUser();
                  },
                  child: Container(
                      padding: EdgeInsets.all(6.0),
                      height: 30,
                      width: 30,
                      child: Icon(Icons.search, color: Colors.white60)),
                )
              ],
            ),
          ),
          Expanded(
              child: searchSnapshot != null
                  ? new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: getLength(searchSnapshot),
                      itemBuilder: (context, index) {
                        return SearchItems(
                          username: searchSnapshot?.docs[index].get("name"),
                          email: searchSnapshot?.docs[index].get("email"),
                        );
                      })
                  : Container()),
        ],
      )),
    );
  }
}

class SearchItems extends StatelessWidget {
  final String username;
  final String email;
  SearchItems({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username, style: TextStyle(color: Colors.amberAccent)),
              Text(email, style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(width: 160.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text("Message", style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
