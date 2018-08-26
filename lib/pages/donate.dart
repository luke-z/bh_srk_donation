import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../blockchain/pusher.dart';
import '../pages/einstellungen.dart' as settings;
import 'package:http/http.dart' as http;

class DonatePage extends StatelessWidget {
  String title;
  String topicId;

  final myController = TextEditingController();

  DonatePage(this.title, this.topicId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
        backgroundColor: Colors.red[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!myController.text.isEmpty) postDonation(context);
        },
        child: Icon(Icons.send),
        backgroundColor: Colors.red[900],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 35.0, right: 35.0),
            child: TextField(
              controller: myController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Spende doch was :)'),
            ),
          ),
        ],
      ),
    );
  }


  postDonation(BuildContext context){
    DonationData story = DonationData(userId: settings.currentUser.id, topicId: topicId, money: int.parse(myController.text));

    String json = jsonEncode(story);

    print(json.length);

    http.post('https://charitypath.blockchain2b.ch/donations', headers: {HttpHeaders.CONTENT_TYPE: "application/json"}, body: json).then((response){
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      final snackBar = SnackBar(content: Text('Danke für die Spende!'));
      Scaffold.of(context).showSnackBar(snackBar);

    });
  }
}
