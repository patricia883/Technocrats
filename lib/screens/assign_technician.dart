import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/create_job_callout.dart';
import 'package:flutter_projects/services/databaseManager.dart';

// ignore: camel_case_types
class getData extends StatefulWidget
{
  const getData();
  @override 
  _getData createState() => _getData();
  
}

// ignore: camel_case_types
class _getData extends State <getData> 
{

// initialize var
  String userID = "";
  List technicianList = [];

//
  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchDatabaseList();
  }

//
  fetchUserInfo() async {
    User getUser = FirebaseAuth.instance.currentUser;
    userID = getUser.uid;
  }

//
  fetchDatabaseList() async {
    dynamic resultant = await DatabaseService().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        technicianList = resultant;
      });
    }
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Updated Callouts').snapshots();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
         appBar: AppBar(
           title: Text("Assign Nearby Technician"),
           backgroundColor: Colors.orange,

           actions: [
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Create_Job_Callout()));
              },
              child: Text("Assign"),
              textColor:Colors.orange,
              color: Colors.white,
            ),
           ]),

          body: Container(

   child: StreamBuilder<QuerySnapshot>(
       stream: _usersStream,
       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
         if (snapshot.hasError) {
           return Text('Something went wrong');
         }

         if (snapshot.connectionState == ConnectionState.waiting) {
           return Text("Loading");
         }

         return ListView(
           children: snapshot.data.docs.map((DocumentSnapshot document) {
           Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Card(
             child: ListTile(

               title: Text(data['Technician']),
               subtitle: Text(data['Status']),
 
               leading: CircleAvatar(
                      
                         child: Image(
                      
                           image: AssetImage('assets/icon.jpg'),
                      
                         ),
                       ),
                      
                       trailing: Text(data['Technician Location']),
                     ),
             );
           }).toList(),
         );
       },
     )));




   /*return Scaffold(
         appBar: AppBar(
           title: Text("Technician Location"),
           backgroundColor: Colors.orange,
         ),

          body: Container(

             child: ListView.builder(

                 itemCount: technicianList.length,

                 itemBuilder: (context, index) {

                   return Card(

                     child: ListTile(

                       title: Text(technicianList[index]['Role']),

                       subtitle: Text(technicianList[index]['Email']),
                      
                     leading: CircleAvatar(
                      
                         child: Image(
                      
                           image: AssetImage('assets/icon.jpg'),
                      
                         ),
                       ),
                      
                       trailing: Text(technicianList[index]['Address']),
                     ),
                  
                   );
                 })));*/

  }
}

      // return Scaffold(
      //   appBar: AppBar(
      //     title: Text("Technician Location"),
      //     backgroundColor: Colors.orange,
      //   ),

      //    body: Container(

      //       child: ListView.builder(

      //           itemCount: technicianList.length,

      //           itemBuilder: (context, index) {

      //             return Card(

      //               child: ListTile(

      //                 title: Text(technicianList[index]['Role']),

      //                 subtitle: Text(technicianList[index]['Email']),
                      
      //                 leading: CircleAvatar(
                      
      //                   child: Image(
                      
      //                     image: AssetImage('assets/icon.jpg'),
                      
      //                   ),
      //                 ),
                      
      //                // trailing: Text(technicianList[index]['Address']),
      //               ),
                  
      //             );
      //           })));



        // StreamBuilder(
        //   stream: FirebaseFirestore.instance.collection('Customer').snapshots(),
        //   builder: ( BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) 
        //   { 
        //       if (!snapshot.hasData)
        //       {
        //         return Text("No value");
        //       }
        //       return ListView
        //       (
        //                     children : snapshot.data.docs.map((value) {
        //                       return Text(('Address'));
                      
        //                     }).toList(),
        //           // children: [snapshot.data.map.doc((document){
        //           //   return Text(document['Address']);
        //           // }).toList(),
        //           // ]
        //       );

        //   },

        // ),


  // return StreamBuilder<QuerySnapshot>(
  //     stream: _usersStream,
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('Something went wrong');
  //       }

  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Text("Loading");
  //       }

  //       return ListView(
  //         children: snapshot.data.docs.map((DocumentSnapshot document) {
  //         Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //           return ListTile(
  //             title: Text(data['Email']),
  //             subtitle: Text(data['Role']),
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );