import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Shared/constants.dart';
import 'package:flutter_projects/Shared/loading.dart';
import 'package:flutter_projects/screens/HomeScreen.dart';
//import 'package:flutter_projects/screens/home/home.dart';
import 'package:flutter_projects/services/auth2.dart';

class Create_New_Customer extends StatefulWidget {
  const Create_New_Customer({Key key}) : super(key: key);

  @override
  _Create_New_CustomerState createState() => _Create_New_CustomerState();
}

// ignore: camel_case_types
class _Create_New_CustomerState extends State<Create_New_Customer> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool loading = false;
  bool checkedValue = false;

  String customerName = '';
  String description = '';
  String address = '';
  String email = '';
  String phoneNo = '';

  TextEditingController customerNameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNoController = new TextEditingController();

  Map<String,dynamic> customerData;
  CollectionReference customers = FirebaseFirestore.instance.collection('Customers');
  CollectionReference C = FirebaseFirestore.instance.collection('Customers');

  createCustomer(){

    customerData = {
      'Customer name': customerNameController.text,
      'Description': descriptionController.text,
      'Address': addressController.text,
      'Email': emailController.text,
      'Phone number': phoneNoController.text,
    };

    customers.add(customerData).whenComplete(() => print('Added to Database Successfully'));

  }

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
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  // TODO : Implement fields
                  TextFormField(
                    controller: customerNameController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Customer Business Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (input) => input.isEmpty ? 'Please enter a Name' : null,
                    onChanged: (input) {
                      setState(() => customerName = input);
                    },
                    onSaved: (input) => customerName = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.description),
                    ),
                    validator: (input) => input.length < 6 ? 'Please provide a description of the Customers business' : null,
                    onChanged: (input) {
                      setState(() => description = input);
                    },
                    onSaved: (input) => description = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Address',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: (input) => input.isEmpty ? 'Please enter Address' : null,
                    onChanged: (input) {
                      setState(() => address = input);
                    },
                    onSaved: (input) => address  = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (input) => input.isEmpty ? 'Please enter Email' : null,
                    onChanged: (input) {
                      setState(() => email = input);
                    },
                    onSaved: (input) => email = input,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: phoneNoController,
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
                  SizedBox(
                    width: 105,
                    height: 50,
                    child: new RaisedButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.save),
                          new Text('  Save'),
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
                          dynamic result = await createCustomer();
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
}
