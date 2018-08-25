import 'package:flutter/material.dart';

class ContributePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 150.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image.network(
                      "https://zapier.cachefly.net/storage/photos/ae82204e047eab5168a978353561adbe.jpg",
                      fit: BoxFit.cover,
                    )),
              ],
            ),
          ),
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
                              height: MediaQuery.of(context).size.height > 600.0 ? 140.0 : 90.0,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Image.network(
                                        "https://thumbor.forbes.com/thumbor/1280x868/https%3A%2F%2Fblogs-images.forbes.com%2Fannabel%2Ffiles%2F2018%2F02%2FLouisville_Skyline-1200x801.jpg",
                                        fit: BoxFit.cover),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Projekt x",
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                "Distanz: x km",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height > 600.0 ? 140.0 : 90.0,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Image.network(
                                        "https://thumbor.forbes.com/thumbor/1280x868/https%3A%2F%2Fblogs-images.forbes.com%2Fannabel%2Ffiles%2F2018%2F02%2FLouisville_Skyline-1200x801.jpg",
                                        fit: BoxFit.cover),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Projekt y",
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                "Distanz: y km",
                                style: TextStyle(color: Colors.black),
                              ),
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