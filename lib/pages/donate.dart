import 'package:flutter/material.dart';

class DonatePage extends StatelessWidget {

  String title;


  DonatePage(this.title);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}