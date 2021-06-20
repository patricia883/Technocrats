import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({
    this.uid
  });

  // Collection reference
  final CollectionReference Users = FirebaseFirestore.instance.collection('Users');

  Future updateUserData(String email, String name, String surname, String phoneNo, String role) async {

    return await Users.doc(uid).set({
      'email': email,
      'name': name,
      'surname': surname,
      'phone number': phoneNo,
      'role': role,
    });
  }

}