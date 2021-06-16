import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "You have been verified... Setup your profile", //shows you other opyions you can use to login
          style: TextStyle(color: Colors.black38),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
