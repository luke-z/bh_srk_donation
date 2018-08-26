import 'dart:convert';

import 'package:flutter/material.dart';
import 'donate.dart';
import 'themen_projekte.dart';
import 'package:http/http.dart' as http;
import '../blockchain/getter.dart';
import 'dart:io';
import 'dart:typed_data';

List<TopicData> dataBuffer = [];

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: dataBuffer.isEmpty
            ? FutureBuilder(
                future: GetTopicData().fetchTopics(http.Client()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      //return Text("${snapshot.data}");
                      return ListView(
                        children: _getData(snapshot, context),
                      );
                    } else {
                      return new CircularProgressIndicator();
                    }
                  } else {
                    return Container();
                  }
                },

                //generatePoolCard(context),
              )
            : ListView(
                children: _getBufferedData(context),
              ),
      ),
    );
  }

  List<Widget> _getData(AsyncSnapshot snapshot, BuildContext context) {
    List<Widget> cards = [];
    List<TopicData> topics = [];

    topics = snapshot.data as List<TopicData>;

    topics.forEach((topic) {
      var image = base64.decode(topic.imageBase64);

      cards.add(Card(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height > 600.0 ? 140.0 : 90.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.memory(image, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top:10.0),),
            ListTile(
              title: Column(
                children: <Widget>[
                  Text(
                    topic.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0),),
                ],
              ),
              subtitle: Text(
                topic.description,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DonatePage(topic.name, topic.id)),
                      );
                    },
                    child: Text("Jetzt spenden!",
                        style: TextStyle(color: Colors.red))),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TopicProjectPage(topic.id, topic.name)),
                      );
                    },
                    child: Text("Details")),
              ],
            ),
          ],
        ),
      ));
    });

    dataBuffer.addAll(topics);
    return cards;
  }

  List<Widget> _getBufferedData(BuildContext context) {
    List<Widget> cards = [];

    dataBuffer.forEach((topic) {
      var image = base64.decode(topic.imageBase64);

      cards.add(Card(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height > 600.0 ? 140.0 : 90.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.memory(image, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top:10.0),),
            ListTile(
              title: Column(
                children: <Widget>[
                  Text(
                    topic.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0),),
                ],
              ),
              subtitle: Text(
                topic.description,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DonatePage(topic.name, topic.id)),
                      );
                    },
                    child: Text("Jetzt spenden!",
                        style: TextStyle(color: Colors.red))),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TopicProjectPage(topic.id, topic.name)),
                      );
                    },
                    child: Text("Details")),
              ],
            ),
          ],
        ),
      ));
    });
    return cards;
  }
}
