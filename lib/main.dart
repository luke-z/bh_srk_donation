import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'map.dart';
import 'package:geolocator/geolocator.dart';
import 'pages/contribute.dart';
import 'pages/themen.dart';
import 'pages/validation.dart';
import 'pages/einstellungen.dart';
import 'pages/spenden.dart';

double latitude;
double longitude;
bool isLocalBoy = true;

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

  //////////////////

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    Position position =
        await Geolocator().getCurrentPosition(LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }

  ////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("CharityPath"),
      ),
      /*floatingActionButton: FloatingActionButton(onPressed: (){
        if (isLocalBoy){
          isLocalBoy = false;
        } else {
          isLocalBoy = true;
        }
        setState(() {

        });
      }),*/ //setstate example :D
      body: Stack(
        children: getOffstageStack(),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
              canvasColor: /*CustomColors.nav*/ Colors.white,
              primaryColor: Colors.red[900],
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
          items: getBottomNav(),
        ),
      ),
    );
  }

  List<Widget> getOffstageStack() {
    List<Widget> offstageItems = [];

    offstageItems.add(
      Offstage(
        offstage: index != 0,
        child: new TickerMode(
          enabled: index == 0,
          child: ProjectPage(),
          /*child: new MaterialApp(home: new QuotePage()),*/
        ),
      ),
    );

    offstageItems.add(
      Offstage(
        offstage: index != 1,
        child: new TickerMode(
          enabled: index == 1,
          child: DonationPage(),
          //child: new MaterialApp(home: new MatchingPage()),
        ),
      ),
    );

    offstageItems.add(
      Offstage(
        offstage: index != 2,
        child: new TickerMode(
          enabled: index == 2,
          child: ContributePage(),
          //child: new MaterialApp(home: new MatchingPage()),
        ),
      ),
    );

    if (isLocalBoy) {
      offstageItems.add(
        Offstage(
          offstage: index != 3,
          child: new TickerMode(
            enabled: index == 3,
            child: ValidationPage(),
            //child: new MaterialApp(home: new ChatPage()),
          ),
        ),
      );
    }

    offstageItems.add(
      Offstage(
        offstage: index != (isLocalBoy ? 4 : 3),
        child: new TickerMode(
          enabled: index == (isLocalBoy ? 4 : 3),
          child: SettingsPage(),
          //child: new MaterialApp(home: new ChatPage()),
        ),
      ),
    );

    return offstageItems;
  }

  List<BottomNavigationBarItem> getBottomNav() {
    List<BottomNavigationBarItem> bottomNavItems = [];

    bottomNavItems.add(
      BottomNavigationBarItem(
        icon: Icon(Icons.group_work),
        title: Text("Projekte"),
      ),
    );
    bottomNavItems.add(
      BottomNavigationBarItem(
        icon: Icon(Icons.monetization_on),
        title: Text("Spenden"),
      ),
    );
    bottomNavItems.add(
      BottomNavigationBarItem(
        icon: Icon(Icons.history),
        title: Text("Beitragen"),
      ),
    );
    if (isLocalBoy) {
      bottomNavItems.add(
        BottomNavigationBarItem(
          icon: Icon(Icons.check),
          title: Text("Validate"),
        ),
      );
    }
    bottomNavItems.add(
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text("Settings"),
      ),
    );

    return bottomNavItems;
  }
}


