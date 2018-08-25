import 'dart:async';

import 'package:flutter/material.dart';
import '../main.dart' as main;
import '../blockchain/getter.dart';
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  @override
  State createState() => SettingsPageState();
}

bool isLocalBoy = false;

class SettingsPageState extends State<SettingsPage> {

  double _result = 0.0;
  int _radioValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      child: new FutureBuilder(
          future: GetUserData().fetchUsers(http.Client()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                //return Text("${snapshot.data}");
                return ListView(
                  children: _getData(snapshot),
                );
              } else {
                return new CircularProgressIndicator();
              }
            } else {
              return Container();
            }
          }),
    );
  }

  List<Widget> _getData(AsyncSnapshot snapshot) {
    int i = 0;

    List<Widget> tiles = [];
    List<UserData> users = [];

    users = snapshot.data as List<UserData>;

    users.forEach((user) {
      tiles.add(
        ListTile(
          leading: Radio(
            groupValue: _radioValue,
            value: i,
            onChanged: _handleRadioValueChange,
          ),
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: user.isLocalBoy ? Icon(Icons.verified_user) : null,
        ),
      );
      if (i == 0 && user.isLocalBoy) isLocalBoy == true;
      if (user.isLocalBoy) isLocalBoy == true;
      i++;
    });

    return tiles;
    //turn the snapshot to a list of widget as you like...
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;


      switch (_radioValue) {
        case 0:
          _result = 0.0;
          break;
        case 1:
          _result = 1.0;
          break;
        case 2:
          _result = 2.0;
          break;
        case 3:
          _result = 3.0;
          break;
      }
    });
  }
}

//user.isLocalBoy ? Icon(Icons.verified_user) : null,
