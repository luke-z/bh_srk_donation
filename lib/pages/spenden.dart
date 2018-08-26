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

List<Widget> generateGrid(double size, BuildContext context) {
  List<Widget> list = new List<Widget>();

  for (var i = 0; i < images.length; i++) {
    list.add(GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailsDonationPage.other("Spende ${i + 1}", true)),
        );
      },
      child: Container(
          padding: EdgeInsets.all(4.0),
          child: Stack(
            alignment: Alignment(0.0, 1.0),
            children: <Widget>[
              Image.network(
                images[i],
                width: size,
                height: size,
                fit: BoxFit.fill,
              ),
              Container(
                decoration: BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
                child: ListTile(
                  title: Text(
                    "Projekt ${i + 1}",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "xxx CHF",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    ));
  }
  return list;
}
