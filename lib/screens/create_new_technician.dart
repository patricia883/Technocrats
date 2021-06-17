import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_projects/screens/home/home.dart';
import 'package:flutter_projects/Shared/constants.dart';
import 'package:flutter_projects/Shared/loading.dart';
import 'package:flutter_projects/screens/HomeScreen.dart';
import 'package:flutter_projects/services/auth2.dart';

class Create_New_Technician extends StatefulWidget {
  const Create_New_Technician({Key key}) : super(key: key);

  @override
  _Create_New_TechnicianState createState() => _Create_New_TechnicianState();
}

class _Create_New_TechnicianState extends State<Create_New_Technician> {

  String email = '';
  String password = '';
  String name = '';
  String surname = '';
  String phoneNo = '';
  String role = '';


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool loading = false;
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
        ),
        title: Text("Create new Technician Profile"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Wrap(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 50.0,
            ),
            child: Form(
              // TODO : implement key
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  // TODO : Implement fields

                  // CheckboxListTile(
                  //   title: Text("Use Default Password ?"),
                  //   value: checkedValue,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       checkedValue = newValue!;
                  //     });
                  //   },
                  //   controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (input) => input.isEmpty ? 'Please enter Name' : null,
                    onChanged: (input) {
                      setState(() => name = input);
                    },
                    onSaved: (input) => name  = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Surname',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (input) => input.isEmpty ? 'Please enter Surname' : null,
                    onChanged: (input) {
                      setState(() => surname = input);
                    },
                    onSaved: (input) => surname = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (input) => input.length < 10 ? 'Invalid Phone Number' : null,
                    onChanged: (input) {
                      setState(() => phoneNo = input);
                    },
                    onSaved: (input) => phoneNo = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                    validator: (input) => input.isEmpty ? 'Please enter an email' : null,
                    onChanged: (input) {
                      setState(() => email = input);
                    },
                    onSaved: (input) => email = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                    validator: (input) => input.length < 6 ? 'Password needs to be at least 6 characters' : null,
                    onChanged: (input) {
                      setState(() => password = input);
                    },
                    onSaved: (input) => password = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Role',
                      prefixIcon: Icon(Icons.info_outline_rounded),
                    ),
                    validator: (input) => input.isEmpty ? 'Please specify role' : null,
                    onChanged: (input) {
                      setState(() => role = input);
                    },
                    onSaved: (input) => role = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 105,
                    height: 50,
                    child: new RaisedButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.save),
                          new Text(' Save'),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                      color: Colors.orange,
                      textColor: Colors.white,
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, surname, phoneNo, role);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            if(result == null){
                              setState(() {
                                loading = false;
                                //error = 'Please supply a valid email';
                              });
                            }
                          }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool defaultPassword = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
    defaultPassword = newValue;

    if (defaultPassword) {
      // TODO: Here goes your functionality that remembers the user.
      password = 'abc123';
    } else {
      // TODO: Forget the user
      //   validator: (input) => input!.length < 6 ? 'Password needs to be at least 6 characters' : null,
      //   onChanged: (input) {
      //   setState(() => password = input);
      //   },
      //   onSaved: (input) => password = input!;,
    }
  });

// Future<void> signIn() async{
//   // TODO : validated fields
//   final formState = _formKey.currentState;
//
//   if(formState!.validate()){
//     // TODO : Sign in to firebase
//     formState.save();
//     setState(() => loading = true);
//
//     try{
//       UserCredential user = await FirebaseAuth.instance.
//       signInWithEmailAndPassword(email: _email, password: _password);
//
//       // TODO : Navigate to home
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
//
//     }catch(e){
//       print(e.toString());
//     }
//
//   }
// }

// Future<void> signUp() async {
//   // TODO : validated fields
//   final formState = _formKey.currentState;
//
//   if (formState!.validate()) {
//     // TODO : Sign in to firebase
//     formState.save();
//     setState(() => loading = true);
//
//     try {
//       UserCredential user = await FirebaseAuth.instance.
//       createUserWithEmailAndPassword(email: _email, password: _password);
//
//       final CollectionReference Users = FirebaseFirestore.instance.collection('Users');
//
//       // TODO : Navigate to home
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Home()));
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
}

// sign up