import 'dart:io';

import 'package:flutter/material.dart';
import '../map.dart';
import 'donate.dart';

List<String> images = [
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
  "https://tpmbc.com/wp-content/uploads/2018/02/DonationIcon.png",
];

class PoolsProjectPage extends StatelessWidget {

  int thema;

  PoolsProjectPage(this.thema);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pool ${thema + 1}"),
        backgroundColor: Colors.red[900],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: generateProjectCard(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> generateProjectCard(BuildContext context) {
    List<Widget> list = [];

    list.add(
      Container(
        padding:
        EdgeInsets.only(top: 15.0, bottom: 15.0, left: 50.0, right: 50.0),
        child: RaisedButton(
          onPressed: () {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DonatePage('Spenden an Thema ${thema + 1}')),
          );},
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

    for (var i = 0; i < images.length; i++) {
      list.add(
        Card(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height > 600.0 ? 140.0 : 90.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.file(
                        File('/data/user/0/com.example.bhsrkdonation/app_flutter/Pictures/flutter_test/1535217856703.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "Projekt ${i + 1}",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  "Gespendet: ${i + 1} CHF",
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
                                DetailsDonationPage("Details", false)),
                      );
                    },
                    child: Text("Details")),
              ),
            ],
          ),
        ),
      );
    }
    return list;
  }
}

