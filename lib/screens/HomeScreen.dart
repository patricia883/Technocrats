import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/Customerprofilescreen.dart';

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
              accountName: new Text("Admin", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
              accountEmail: new Text("AdminEmail"),
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
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.work_outline_sharp),
              title: Text("Previous Callouts"),
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
                onTap: (){},
                splashColor: Colors.orange,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.person_add, size: 70.0,),
                      Text("Add Technician",style: new TextStyle(fontSize: 17.0),)
                    ],
                  ),
                ),
              )
            ),

            Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){},
                  splashColor: Colors.orange,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.person_add, size: 70.0,),
                        Text("Add Customer",style: new TextStyle(fontSize: 17.0),)
                      ],
                    ),
                  ),
                  onLongPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerProfileScreen()));
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
}