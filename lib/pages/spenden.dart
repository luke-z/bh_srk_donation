import 'package:flutter/material.dart';
import '../map.dart';

class DonationPage extends StatelessWidget {
  double size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this would produce 2 rows.
              crossAxisCount: 2,
              // Generate 100 Widgets that display their index in the List
              children: generateGrid(size, context),

              /*List.generate(100, (index) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.blueAccent)
                    ),
                    child: Text(
                      'Item $index',
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                );
              }),*/
            ),
          ),
        ],
      ),
    );
  }
}


List<Widget> generateGrid(double size, BuildContext context) {
  List<Widget> list = new List<Widget>();

    list.add(GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailsDonationPage.other("Hurrikan Maria", true)),
        );
      },
      child: Container(
          padding: EdgeInsets.all(4.0),
          child: Stack(
            alignment: Alignment(0.0, 1.0),
            children: <Widget>[
              Image.network(
                "https://image.ibb.co/g0WuoU/Download.jpg",
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
                child: ListTile(
                  title: Text(
                    "Hurrikan Maria",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "150 CHF",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    ));


    list.add(GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailsDonationPage.other("Teilstaat Rakhine", true)),
        );
      },
      child: Container(
          padding: EdgeInsets.all(4.0),
          child: Stack(
            alignment: Alignment(0.0, 1.0),
            children: <Widget>[
              Image.network(
                "https://www.dw.com/image/40980409_303.jpg",
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
                child: ListTile(
                  title: Text(
                    "Teilstaat Rakhine",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "75 CHF",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    ));

    list.add(GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailsDonationPage.other("Unvorhergesehenes", true)),
        );
      },
      child: Container(
          padding: EdgeInsets.all(4.0),
          child: Stack(
            alignment: Alignment(0.0, 1.0),
            children: <Widget>[
              Image.network(
                "https://images.lifeline.de/img/incoming/origs24414/6696112159-w830-h3000/Freizeitsport-106456887.jpg",
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
                child: ListTile(
                  title: Text(
                    "Unvorhergesehenes",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "50 CHF",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    ));


  return list;
}
