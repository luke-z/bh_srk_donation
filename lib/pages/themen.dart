import 'package:flutter/material.dart';
import 'donate.dart';
import 'themen_projekte.dart';

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

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: generatePoolCard(context),
      ),
    );
  }
}

List<Widget> generatePoolCard(BuildContext context) {
  List<Widget> list = new List<Widget>();

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
                    child: Image.network(
                        "https://thumbor.forbes.com/thumbor/1280x868/https%3A%2F%2Fblogs-images.forbes.com%2Fannabel%2Ffiles%2F2018%2F02%2FLouisville_Skyline-1200x801.jpg",
                        fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "Pool ${i + 1}",
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                "Kurz - Details zu Pool",
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
                        MaterialPageRoute(builder: (context) => DonatePage('Spenden an Thema ${i + 1}')),
                      );
                    },
                    child: Text("Jetzt spenden!",
                        style: TextStyle(color: Colors.red))),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PoolsProjectPage(i)),
                      );
                    },
                    child: Text("Details")),
              ],
            ),
          ],
        ),
      ),
    );
  }
  return list;
}