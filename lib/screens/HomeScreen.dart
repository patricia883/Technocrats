import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/Customerprofilescreen.dart';
import 'package:flutter_projects/screens/create_new_customer.dart';
import 'package:flutter_projects/screens/create_new_technician.dart';
import 'package:flutter_projects/screens/login.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YSF IT Solutions'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orangeAccent[100],

      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text("Admin",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0)
              ),
              accountEmail: new Text(""),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Icon(Icons.work_outline_sharp),
              title: Text("Previous Callouts"),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: (){
                _signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Create_New_Technician()));
                },
                splashColor: Colors.orange,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.person_add, size: 70.0,),
                      Text("New Technician",
                        style: new TextStyle(
                            fontSize: 17.0),
                      )
                    ],
                  ),
                ),
                onLongPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Create_New_Technician()));
                },
              )
            ),

            Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Create_New_Customer()));
                  },
                  splashColor: Colors.orange,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.person_add, size: 70.0,),
                        Text("New Customer",style: new TextStyle(fontSize: 17.0),)
                      ],
                    ),
                  ),
                  onLongPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Create_New_Customer()));
                  },
                )
            ),
            /*onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerProfileScreen())),
                    };*/
            Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){},
                  splashColor: Colors.orange,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.work, size: 70.0,),
                        Text("Create New Callout",style: new TextStyle(fontSize: 17.0),)
                      ],
                    ),
                  ),
                )
            ),
          ]
        ),
      ),
    );
  }

  Future <void> _signOut() async{
    await FirebaseAuth.instance.signOut();
    User user = await FirebaseAuth.instance.currentUser;
  }

}