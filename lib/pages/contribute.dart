import 'dart:async';

import 'package:flutter/material.dart';
import 'einstellungen.dart' as settings;
import 'validation.dart';
import 'create_contribution.dart';
import '../blockchain/getter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../main.dart' as main;



class ContributePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          Center(
            child: Text(
              "Deine Geschichte zum Projekt in Deiner Nähe!",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height > 600.0
                                  ? 140.0
                                  : 90.0,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Image.network(
                                        "https://image.ibb.co/g0WuoU/Download.jpg",
                                  fit: BoxFit.cover),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Hurrikan Maria",
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                "Distanz: 5 km",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: validationForIsLocal(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          /*Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text("ListView Item"),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}





List<Widget> validationForIsLocal(BuildContext context) {
  List<Widget> buttons = [];

  if (settings.isLocalBoy) {
    buttons.add(
      FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ValidationPage()),
          );
        },
        child: Text("Jetzt validieren!", style: TextStyle(color: Colors.red)),
      ),
    );
  }
  buttons.add(
    FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateContribution()),
          );
        },
        child: Text("Beitragen")),
  );

  return buttons;
}
