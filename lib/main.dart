import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'map.dart';

void main() {
  MapView.setApiKey(API_KEY);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Design(),
    );
  }
}

class Design extends StatefulWidget {
  State createState() => new DesignState();
}

class DesignState extends State<Design> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("SRK - Spenden"),
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: index != 0,
            child: new TickerMode(
              enabled: index == 0,
              child: HomePage(),
              /*child: new MaterialApp(home: new QuotePage()),*/
            ),
          ),
          Offstage(
            offstage: index != 1,
            child: new TickerMode(
              enabled: index == 1,
              child: DonationPage(),
              //child: new MaterialApp(home: new MatchingPage()),
            ),
          ),
          Offstage(
            offstage: index != 2,
            child: new TickerMode(
              enabled: index == 2,
              child: ProjectPage(),
              //child: new MaterialApp(home: new MatchingPage()),
            ),
          ),
          Offstage(
            offstage: index != 3,
            child: new TickerMode(
              enabled: index == 3,
              child: SettingsPage(),
              //child: new MaterialApp(home: new ChatPage()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
              canvasColor: /*CustomColors.nav*/ Colors.white,
              primaryColor: Colors.red,
              brightness: Brightness.light,
            ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (int index) {
            setState(() {
              this.index = index;
              //MyApp().changeHome(this.index);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              title:
                  Text("Spenden"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_work),
              title:
                  Text("Projekte"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title:
                  Text("Settings"),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: generateCard(context),
        ));
  }
}

List<Widget> generateCard(BuildContext context) {
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
                    child: Image.network("https://thumbor.forbes.com/thumbor/1280x868/https%3A%2F%2Fblogs-images.forbes.com%2Fannabel%2Ffiles%2F2018%2F02%2FLouisville_Skyline-1200x801.jpg",
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
              trailing: FlatButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsProjectPage()),
                );
              }, child: Text("Check me out!")),
            )
          ],
        ),
      ),
    );
  }
  return list;
}

class DonationPage extends StatelessWidget {
  double size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      body: GridView.count(
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
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsDonationPage("Spende ${i + 1}")),
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
                    "Spende ${i + 1}",
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


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}

class DetailsProjectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text("Project Details"),
    backgroundColor: Colors.red,
    ),
    );
  }

}
