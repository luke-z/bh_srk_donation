import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../map.dart';
import 'donate.dart';
import 'package:http/http.dart' as http;
import '../blockchain/getter.dart';

List<TopicProjectData> dataBuffer = [];

class TopicProjectPage extends StatelessWidget {
  String themaId;
  String themaName;

  TopicProjectPage(this.themaId, this.themaName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(themaName),
        backgroundColor: Colors.red[900],
      ),
      body: Container(
        child: dataBuffer.isEmpty
            ? FutureBuilder(
                future: GetTopicProjectData(themaId)
                    .fetchTopicProjectData(http.Client()),
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
    List<TopicProjectData> topics = [];

    topics = snapshot.data as List<TopicProjectData>;


    cards.add(
      Container(
        padding:
            EdgeInsets.only(top: 15.0, bottom: 15.0, left: 50.0, right: 50.0),
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DonatePage('Spenden an Thema ${themaName}', themaId)),
            );
          },
          child: Text(
            "JETZT SPENDEN",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.red,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          elevation: 5.0,
        ),
      ),
    );

    topics.forEach((project) {
      var image = base64.decode(project.imageBase64);

      cards.add(
        Card(
          child: Column(
            children: <Widget>[
              SizedBox(
                height:
                    MediaQuery.of(context).size.height > 600.0 ? 140.0 : 90.0,
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
                      project.name,
                      style: TextStyle(color: Colors.black),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0),),
                  ],
                ),
                subtitle: Text(
                  '${project.description}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsDonationPage("Details", false, project.id)),
                      );
                    },
                    child: Text("Details")),
              ),
            ],
          ),
        ),
      );
    });

    return cards;
  }

  List<Widget> _getBufferedData(BuildContext context) {
    List<Widget> cards = [];

    dataBuffer.forEach((project) {
      cards.add(
        Container(
          padding:
              EdgeInsets.only(top: 15.0, bottom: 15.0, left: 50.0, right: 50.0),
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DonatePage('Spenden an Thema ${themaName}', project.topicId)),
              );
            },
            child: Text(
              "JETZT SPENDEN",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            elevation: 5.0,
          ),
        ),
      );

      var image = base64.decode(project.imageBase64);

      cards.add(
        Card(
          child: Column(
            children: <Widget>[
              SizedBox(
                height:
                    MediaQuery.of(context).size.height > 600.0 ? 140.0 : 90.0,
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
                      project.name,
                      style: TextStyle(color: Colors.black),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0),),
                  ],
                ),
                subtitle: Text(
                  '${project.description}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsDonationPage("Details", false, project.id)),
                      );
                    },
                    child: Text("Details")),
              ),
            ],
          ),
        ),
      );
    });

    return cards;
  }
}
