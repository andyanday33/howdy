import 'package:flutter/material.dart';
import 'package:howdy/widgets/appBar.dart';
import 'package:howdy/widgets/inputDecoration.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchtec = new TextEditingController();

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
                Container(
                    padding: EdgeInsets.all(6.0),
                    height: 30,
                    width: 30,
                    child: Icon(Icons.search, color: Colors.white60))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
