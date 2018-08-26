import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'camera.dart';
import '../blockchain/pusher.dart';
import '../main.dart' as main;
import 'einstellungen.dart' as settings;
import 'package:http/http.dart' as http;

class CreateContribution extends StatefulWidget {
  CreateContributionState createState() => new CreateContributionState();
}

String imagePath;

class CreateContributionState extends State<CreateContribution> {
  bool pictureAdded = false;
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schreiben"),
        backgroundColor: Colors.red[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!myController.text.isEmpty) postStory();
        },
        child: Icon(Icons.send),
        backgroundColor: Colors.red[900],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            pictureAdded ? retakePic() : takePic(),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextField(
                      controller: myController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Schreib was!'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  retakePic() {
    File lastImage = File(imagePath.toString());
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 250.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image.file(
                  lastImage,
                  fit: BoxFit.fitWidth,
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          RaisedButton(
            child: Text(
              "Gefällt es dir nicht?",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              navigateAndDisplayCamera();
            },
          )
        ],
      ),
    );
  }

  takePic() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 250.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image.network(
                  'https://shelbycountyartscouncil.com/wp-content/uploads/2017/09/pexels-photo-226243.jpeg',
                  fit: BoxFit.fitWidth,
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          RaisedButton(
            child: Text(
              "Teile ein Bild!",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              navigateAndDisplayCamera().then((data) {
                setState(() {
                  pictureAdded = true;
                });
              });
            },
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            elevation: 10.0,
          )
        ],
      ),
    );
  }

  navigateAndDisplayCamera() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPage()),
    );
    imagePath = result;
  }

  postStory(){

    File image = File(imagePath.toString());
    //List<int> recentPicPath = recentPic.readAsBytesSync();
    //String base64Image = base64Encode(recentPic.readAsBytesSync());
    //path.imagePath = filePath;
    String base64Image = base64Encode(image.readAsBytesSync());

    StoryData story = StoryData(image: base64Image, storytext: myController.text, longitude: main.longitude, latitude: main.latitude, userId: settings.currentUser.id, projectId: '2366e7d2-1eea-295c-76b2-b64a3f89d732');

    String json = jsonEncode(story);

    print(json.length);

    http.post('https://charitypath.blockchain2b.ch/stories', headers: {HttpHeaders.CONTENT_TYPE: "application/json"}, body: json).then((response){
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });
  }
}
