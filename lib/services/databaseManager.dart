import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({
    this.uid
  });

  // Collection reference
  final CollectionReference Users = FirebaseFirestore.instance.collection('Users');
  final CollectionReference Customers = FirebaseFirestore.instance.collection('Customers');
  final CollectionReference Technician = FirebaseFirestore.instance.collection('Updated Callouts');

  Future updateUserData(String email, String fullName, String phoneNo, String role) async {

    return await Users.doc(uid).set({
      'Email': email,
      'Full name': fullName,
      'Phone number': phoneNo,
      'Role': role,
    });
  }

  Future updateCustomerData(String email, String customerName, String description, String phoneNo, String address) async {

    return await Customers.doc(uid).set({
      'Email': email,
      'Customer name': customerName,
      'Description': description,
      'Phone number': phoneNo,
      'Address': address,
    });
  }

   Future getUsersList() async {
    List itemsList = [];

    try {
      await Technician.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}